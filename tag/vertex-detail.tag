<vertex-detail id="selected">
    <article>
        <div class="pure-g">
            <div class="pure-u-11-12">
                <mark>{vertex.hashtag}</mark>
            </div>
            <div class="pure-u-1-12">
                <a href="#">E</a>
            </div>
            <div class="pure-u-11-12">
                {vertex.sentence}
            </div>
            <div class="pure-u-1-12">
                <a href="#">E</a>
            </div>
            <div class="pure-u-11-12">
                <mark each="{ RpgImpro.document.getVertexBySource(vertex.pk) }">{ this.hashtag }</mark>
            </div>
            <div class="pure-u-1-12">
                <a href="#">+</a>
            </div>
        </div>
    </article>
    <script>
        
    </script>
</vertex-detail>