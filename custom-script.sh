echo '
{{ if isset .Site.Params.webmentions "widget"  }}

    <div class="webmentions webmentions-container" id="webmentions"
        data-endpoint="{{.Site.Params.webmentions.url}}">
    </div>
    <script>
        document.getElementById("webmentions").setAttribute("data-target", window.location.href);
    </script>
    <script src="{{.Site.Params.webmentions.widget}}"></script>

{{ end }}

' > themes/anubis/layouts/partials/footer-extra.html
