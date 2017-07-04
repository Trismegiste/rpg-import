<vertex-detail id="selected">
    <article>
        <header class="pure-g">
            <div class="pure-u-3-4">
                <mark class="hashtag">{vertex.hashtag}</mark>
            </div>
            <div class="pure-u-1-6">
                <a if="{ isOrphan(vertex) }" onclick="{
                            onDelete
                        }"><i class="icon-cancel-squared"></i></a>
            </div>
            <div class="pure-u-1-12">
                <!-- <a href="#"><i class="icon-pencil"></i></a>-->
            </div>
        </header>
        <div class="pure-g">
            <div class="pure-u-11-12" if="{ !isEditing }">
                <hashtag-decorator str="{vertex.sentence}" inner="{ vertex.pk }"></hashtag-decorator>
            </div>
            <div class="pure-u-11-12" if="{ isEditing }">
                <form class="pure-form" onsubmit="{
                            onSubmit
                        }">
                    <textarea class="pure-input-1" name="entry">{ vertex.sentence }</textarea>
                </form>
            </div>
            <div class="pure-u-1-12">
                <a href="#" onclick="{
                            onEdit
                        }"><i class="icon-pencil"></i></a>
            </div>
        </div>
        <outer-edge></outer-edge>
        <inner-edge></inner-edge>
    </article>

    <script>
        var self = this
        this.isEditing = false

        this.isOrphan = function (v) {
            return RpgImpro.document.isOrphan(v)
        }

        this.onDelete = function () {
            RpgImpro.document.remove(self.vertex)
        }

        this.onEdit = function () {
            self.isEditing = !self.isEditing
        }

        this.onSubmit = function () {
            console.log(self.entry)
        }

    </script>
</vertex-detail>