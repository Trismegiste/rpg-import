<hashtag-decorator class="sentence">
    <nav each="{ chunk in opts.str.split(' ') }">
        <span if="{ chunk[0] != '#' }">{chunk}</span>
        <a if="{ chunk[0] == '#' }" onclick="{
                    parent.onInstantiate
                }" class ="hashtag">{chunk.substr(1)}</a>
    </nav>
    <script>
        var self = this

        this.onInstantiate = function (event) {
            RpgImpro.document.trigger('create-from-hashtag', event.item.chunk.substr(1), self.opts.inner)
        }
    </script>
</hashtag-decorator>