<spa>
    <div>
        <div class="pure-g">+</div>
        <div class="pure-g" each="{ RpgImpro.document.getVertex() }">
            <div class="pure-u-1">{sentence}</div>
        </div>
    </div>
    <script>
        // this to hide waiting spinner
        this.on('mount', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
        })
    </script>
</spa>