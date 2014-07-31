# DocPad Configuration
docpadConfig = {

   # =================================
    # Server Configuration

    # =================================
    # Template Configuration

    # Template Data
    # Use to define your own template data and helpers that will be accessible to your templates
    # Complete listing of default values can be found here: http://docpad.org/docs/template-data
    templateData:  # example

        # Specify some site properties
        site:
            # The production URL of our website
            url: "http://ru.4game.com/lineage2/play/ertheia/"

            # The default title of our website
            title: "Lineage 2 – Обновление Артея"


        # -----------------------------
        # Helper Functions

        # Get the prepared site/document title
        # Often we would like to specify particular formatting to our page's title
        # we can apply that formatting here
        getPreparedTitle: ->
            # if we have a document title, then we should use that and suffix the site's title onto it
            if @document.title
                @document.title
            # if our document does not have its own title, then we should just use the site's title
            else
                @site.title

    # =================================
    # Plugin Configuration

    # Configure Plugins
    # Should contain the plugin short names on the left, and the configuration to pass the plugin on the right
    plugins:
        marked:
        	pedantic: false
			gfm: true
			tables: true

}

# Export the DocPad Configuration
module.exports = docpadConfig