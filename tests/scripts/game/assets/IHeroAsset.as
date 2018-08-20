package game.assets
{
   import game.battle.view.hero.HeroClipAssetDataProvider;
   
   public interface IHeroAsset
   {
       
      
      function get unitId() : int;
      
      function dispose() : void;
      
      function getHeroData(param1:Number = 1, param2:String = null, param3:Boolean = false) : HeroClipAssetDataProvider;
   }
}
