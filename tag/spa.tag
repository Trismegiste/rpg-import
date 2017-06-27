<spa>
    <div class="pure-g">
        <div class="pure-u-1 pure-u-md-1-2">
            <form class="pure-form" onkeyup="{
                        onSearch
                    }">
                <input type="text" class="pure-input-1" name="search" value="{ keyword }"/>
            </form>
        </div>
        <button class="pure-button pure-u-1 pure-u-md-1-2" onclick="{
                    onAdd
                }">+</button>
    </div>
    <div class="pure-g">
        <div class="pure-u-1" each="{ vertex, idx in found }">
            <virtual if="{idx != selected}">
                <vertex></vertex>
            </virtual>
            <virtual if="{idx == selected}">
                <vertex-detail></vertex-detail>
            </virtual>
        </div>
    </div>
    <script>
        this.selected = null
        this.keyword = ''
        this.found = RpgImpro.document.getVertex()
        var self = this

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
            self.found = []
            self.keyword = self.search.value
                        console.log(self.keyword)

            var regex = new RegExp(self.keyword.trim(), 'i')
            var model = RpgImpro.document.getVertex()
            for (var k in model) {
                var v = model[k]
                if (regex.test('#' + v.hashtag + ' ' + v.sentence)) {
                    self.found.push(v)
                }
            }
        }

        riot.route('/search/*', function (keyword) {
            self.keyword = keyword
            self.update()
            console.log(self.keyword)
            self.onSearch()
            self.update()
        })


    </script>
</spa>