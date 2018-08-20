package game.assets.storage.rsx
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import engine.core.assets.AssetProvider;
   import engine.core.assets.RequestableAsset;
   import game.assets.FontAsset;
   import game.assets.storage.AssetStorage;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class BattleFonts implements RequestableAsset
   {
       
      
      private var _completed:Boolean = false;
      
      public function BattleFonts()
      {
         super();
      }
      
      public function get miss() : FontAsset
      {
         return AssetStorage.font.getAsset("BattleNumbers_miss");
      }
      
      public function get dodge() : FontAsset
      {
         return AssetStorage.font.getAsset("BattleNumbers_dodge");
      }
      
      public function get physical() : FontAsset
      {
         return AssetStorage.font.getAsset("BattleNumbers_physical");
      }
      
      public function get physicalCrit() : FontAsset
      {
         return AssetStorage.font.getAsset("BattleNumbers_physical_crit");
      }
      
      public function get magic() : FontAsset
      {
         return AssetStorage.font.getAsset("BattleNumbers_magic");
      }
      
      public function get magicCrit() : FontAsset
      {
         return AssetStorage.font.getAsset("BattleNumbers_magic_crit");
      }
      
      public function get pure() : FontAsset
      {
         return AssetStorage.font.getAsset("BattleNumbers_pure");
      }
      
      public function get pureCrit() : FontAsset
      {
         return AssetStorage.font.getAsset("BattleNumbers_pure_crit");
      }
      
      public function get heal() : FontAsset
      {
         return AssetStorage.font.getAsset("BattleNumbers_heal");
      }
      
      public function get energy() : FontAsset
      {
         return AssetStorage.font.getAsset("BattleNumbers_energy");
      }
      
      public function get energyYellow() : FontAsset
      {
         return AssetStorage.font.getAsset("BattleNumbers_energy_yellow");
      }
      
      public function prepare(param1:AssetProvider) : void
      {
         param1.request(this,miss);
         param1.request(this,dodge);
         param1.request(this,physical);
         param1.request(this,physicalCrit);
         param1.request(this,magic);
         param1.request(this,magicCrit);
         param1.request(this,pure);
         param1.request(this,pureCrit);
         param1.request(this,heal);
         param1.request(this,energy);
         param1.request(this,energyYellow);
      }
      
      public function get completed() : Boolean
      {
         return _completed;
      }
      
      public function complete() : void
      {
         _completed = true;
      }
      
      public function completeRsx(param1:ClipAsset) : void
      {
         completeFont(param1,miss);
         completeFont(param1,dodge);
         completeFont(param1,physical);
         completeFont(param1,physicalCrit);
         completeFont(param1,magic);
         completeFont(param1,magicCrit);
         completeFont(param1,pure);
         completeFont(param1,pureCrit);
         completeFont(param1,heal);
         completeFont(param1,energy);
         completeFont(param1,energyYellow);
      }
      
      private function completeFont(param1:ClipAsset, param2:FontAsset) : void
      {
         var _loc4_:Clip = param1.getClipByName(param2.ident);
         var _loc3_:Texture = ClipImageCache.getClipTexture(_loc4_);
         param2.completeWithExternalTexture(_loc3_);
         TextField.registerBitmapFont(param2.font);
      }
   }
}
