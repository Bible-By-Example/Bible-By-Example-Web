# Liquid Filter: tag_url
#
# Usage:
#
#   {{ "The 47%" | tag_url }}
#   {{ "The 47%" | tag_url | relative_url }}
#   {{ "The 47%" | tag_url | absolute_url }}
#
# Example:
#
#   {{ "The 47%" | tag_url }} => /tag/the-47/
#
# Notes:
# - This filter intentionally derives URLs from the jekyll-archives configuration; builds fail if the required configuration is missing.
# - No fallback URL or permalink values are provided.
# - If slug_mode is omitted, Jekyll's default is used, matching jekyll-archives.
# - URL formatting (relative_url, absolute_url, etc.) should be applied in Liquid, not in this plugin.

module Jekyll
  # Preserve the jekyll-archives configuration as read from _config.yml.
  Hooks.register :site, :after_init do |site|
    site.instance_variable_set(
      :@tag_url_archives_config,
      site.config["jekyll-archives"]
    )
  end

  module TagUrlFilter
    def tag_url(tag)
      # Verify jekyll-archives gem is actually loaded in Ruby
      unless defined?(Jekyll::Archives::Archives)
        raise Liquid::Error, "[tag_url filter] Error: The 'jekyll-archives' gem is not installed or loaded."
      end

      # Fetch explicit configuration saved by the hook
      site = @context.registers[:site]
      config = site.instance_variable_get(:@tag_url_archives_config)

      unless config.is_a?(Hash)
        raise Liquid::Error, "[tag_url filter] 'jekyll-archives' block is not defined in _config.yml."
      end

      # Verify tag archives are explicitly enabled
      enabled = config["enabled"]
      tags_enabled =
        enabled == true ||
        enabled == "all" ||
        (enabled.is_a?(Array) && enabled.include?("tags"))

      unless tags_enabled
        raise Liquid::Error,  "[tag_url filter] You must include 'tags' under 'jekyll-archives.enabled' in _config.yml."
      end

      # Extract and validate permalink template explicitly set by user
      permalinks = config["permalinks"]
      template = permalinks["tag"] if permalinks.is_a?(Hash)

      unless template.is_a?(String) && template.include?(":name")
        raise Liquid::Error, "[tag_url filter] 'jekyll-archives.permalinks.tag' must be configured in _config.yml and contain the ':name' placeholder."
      end

      # Validate input tag and compute slug using jekyll-archives' slug_mode
      tag_str = tag.to_s.strip
      if tag_str.empty?
        raise ArgumentError, "[tag_url filter] Provided tag name is empty."
      end

      slug = Jekyll::Utils.slugify(tag_str, :mode => config["slug_mode"])

      if slug.empty?
        raise ArgumentError, "[tag_url filter] Tag '#{tag}' resulted in an empty slug."
      end

      template.sub(":name", slug)
    end
  end
end

Liquid::Template.register_filter(Jekyll::TagUrlFilter)
