<spa>
    <div>+</div>
    <vertex each="{ vertex, idx in RpgImpro.document.getVertex() }"></vertex>
    <script>
        // this to hide waiting spinner
        this.on('mount', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
        })
    </script>
</spa>