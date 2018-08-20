package game.assets
{
   import game.assets.storage.RsxGameAsset;
   
   public class HeroRsxAsset extends RsxGameAsset
   {
       
      
      private var _mirrored:Boolean;
      
      public function HeroRsxAsset(param1:*)
      {
         super(param1);
         _mirrored = param1.mirrored;
      }
      
      public function get mirrored() : Boolean
      {
         return _mirrored;
      }
   }
}
