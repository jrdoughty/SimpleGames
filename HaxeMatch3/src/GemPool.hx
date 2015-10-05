class GemPool
{
    private var gems: Array<Gem>;
    private var counter:Int = 0;

    public function new (max:Int)
    {
        gems = [];
        gems.length = max;
    }
        
    public function addGem(gem:Gem):void
    {
        gems[counter++] = gem;
    }
    
    public function getGem():Gem
    {
        return gems[--counter];
    }
}