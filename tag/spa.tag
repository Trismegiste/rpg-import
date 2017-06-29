<spa>
    <div class="pure-g">
        <vertex-form class="pure-u-1"></vertex-form>
    </div>
    <vertex-list></vertex-list>
    <script>
        var self = this

        // this to hide waiting spinner
        this.on('mount', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
        })


    </script>
</spa>