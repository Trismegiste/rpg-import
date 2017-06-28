<spa>
    <div class="pure-g" if="{ !vertexFormView }">
        <div class="pure-u-1 pure-u-md-1-2">
            <form class="pure-form" onkeyup="{
                        onSearch
                    }">
                <input type="text" class="pure-input-1" name="search" value="{ keyword }"/>
            </form>
        </div>
        <a class="pure-button pure-u-1 pure-u-md-1-2" href="#create">+</a>
    </div>
    <div class="pure-g" if="{ vertexFormView }" >
        <vertex-form class="pure-u-1"></vertex-form>
    </div>
    <div class="pure-g listing">
        <section class="pure-u-1" each="{ vertex in found }">
            <virtual if="{vertex.pk != selected}">
                <vertex></vertex>
            </virtual>
            <virtual if="{vertex.pk == selected}">
                <vertex-detail></vertex-detail>
            </virtual>
        </section>
    </div>
    <script>
        this.selected = 0 // by default, first entry on the list
        this.keyword = ''
        this.found = RpgImpro.document.getVertex()
        this.vertexFormView = false
        var self = this

        // this to hide waiting spinner
        this.on('mount', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
        })

        this.on('update', function () {
            var regex = new RegExp(self.keyword.trim(), 'i')
            var model = RpgImpro.document.getVertex()
            self.found = []
            for (var k in model) {
                var v = model[k]
                if (regex.test('#' + v.hashtag + ' ' + v.sentence)) {
                    self.found.push(v)
                }
            }
        })

        // search
        this.onSearch = function () {
            self.keyword = self.search.value
        }

        riot.route('/search/*', function (keyword) {
            self.keyword = keyword
            self.update()
        })

        riot.route('/show/*', function (pk) {
            self.selected = pk
            self.update()
            var obj = document.getElementById('selected')
            if (obj) {
                window.scrollTo(0, obj.offsetTop)
            }
        })

        riot.route('/create', function () {
            self.vertexFormView = true
            self.update()
        })

    </script>
</spa>