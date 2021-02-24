echo '

    <div class="webmentions webmentions-container" id="webmentions"
        data-endpoint="https://jn2p.de/webmentions/">
    </div>
    <script>
        document.getElementById("webmentions").setAttribute("data-target", window.location.href);
    </script>
    <script src="https://jn2p.de/webmentions/ui/dist/widget.js"></script>


' > themes/anubis/layouts/partials/pagination-extra.html

echo '
<a href="/impressum/">Impressum</a> | <a href="/datenschutz/">Datenschutz</a>

' > themes/anubis/layouts/partials/footer-extra.html
