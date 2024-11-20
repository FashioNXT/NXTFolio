module GalleryHelper
    def format_image_title(title)
        title.strip.split.map(&:capitalize).join(' ')
    end

    def image_size_class(size_in_bytes)
        case size_in_bytes
        when 0..1_000_000
          "small"
        when 1_000_001..5_000_000
          "medium"
        else
          "large"
        end
    end

    def format_upload_date(date)
        date.strftime("%b %d, %Y")
    end
end
