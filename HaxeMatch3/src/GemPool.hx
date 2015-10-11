class GemPool
{
    private var gems: Array<Gem>;
    private var counter:Int = 0;
    private static var pool:GemPool;

    private function new ()
    {
        gems = [];
    }

    public static function instance():GemPool
    {
        if(pool == null)
        {
            pool = new GemPool();
        }

        return pool;
    }
        
    public function addGem(gem:Gem):Void
    {
        gems[counter++] = gem;
    }
    
    public function getGem():Gem
    {
        return gems[--counter];
    }

    public function removeGem(gem:Gem):Array<Gem>
    {
        var i:Int = 0;
        for(i in 0...gems.length)
        {
            if(gems[i] == gem)
            {
                return gems.splice(i, 1);
            }
        }
        return [];
    }

    public function spliceGem(index:Int):Array<Gem>
    {
        return gems.splice(index, 1);
    }
    
    public function activeGems():Array<Gem>
    {
        return gems;
    }
}