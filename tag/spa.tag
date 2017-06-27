<spa>
    <div class="pure-g">
        <div class="pure-u-1 pure-u-md-1-2">
            <form class="pure-form" onchange="{
                        onSearch
                    }">
                <input type="text" class="pure-input-1" name="keyword"/>
            </form>
        </div>
        <button class="pure-button pure-u-1 pure-u-md-1-2" onclick="{
                    onAdd
                }">+</button>
    </div>
    <div class="pure-g">
        <div class="pure-u-1" each="{ vertex, idx in RpgImpro.document.getVertex() }">
            <virtual if="{idx != selected}">
                <vertex></vertex>
            </virtual>
            <virtual if="{idx == selected}">
                <vertex-detail></vertex-detail>
            </virtual>
        </div>
    </div>
    <script>
        var self = this
        var selected = null

        // this to hide waiting spinner
        this.on('mount', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
        })

        // add a new vertex
        this.onAdd = function () {

        }

        // search
        this.onSearch = function () {

        }

    </script>
</spa>