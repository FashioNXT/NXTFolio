module GalleryHelper
    def format_image_title(title)
        title.strip.split.map(&:capitalize).join(' ')
    end
end
