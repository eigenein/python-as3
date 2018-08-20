package game.assets.storage
{
   import engine.context.index.AssetIndex;
   import engine.core.assets.AssetLoader;
   import engine.core.assets.file.AssetFile;
   import game.assets.storage.rsx.GameSoundAsset;
   import game.assets.storage.rsx.RSXAssetStorage;
   
   public class AssetStorage
   {
      
      public static const font:FontAssetStorage = new FontAssetStorage();
      
      public static const hero:HeroAssetStorage = new HeroAssetStorage();
      
      public static const inventory:InventoryAssetStorage = new InventoryAssetStorage();
      
      public static const rsx:RSXAssetStorage = new RSXAssetStorage();
      
      public static const battleground:BattlegroundAssetStorage = new BattlegroundAssetStorage();
      
      public static const skillIcon:SkillIconAssetStorage = new SkillIconAssetStorage();
      
      public static const sound:GameSoundAsset = new GameSoundAsset();
      
      public static const battle:BattleAssetStorage = new BattleAssetStorage();
      
      public static const instance:AssetStorage = new AssetStorage();
       
      
      public var globalLoader:AssetLoader;
      
      private var index:AssetIndex;
      
      public function AssetStorage()
      {
         globalLoader = new AssetLoader();
         super();
      }
      
      public function get inited() : Boolean
      {
         return index;
      }
      
      public function init(param1:AssetIndex) : void
      {
         this.index = param1;
         var _loc2_:* = param1.libAssetData;
         font.init(_loc2_.font);
         hero.init(_loc2_.hero);
         rsx.init(_loc2_.rsx);
         battleground.init(_loc2_.battleground);
         inventory.init(_loc2_.inventory);
         skillIcon.init(_loc2_.skillIcon);
      }
      
      public function complete() : void
      {
         var _loc1_:* = index.libAssetData;
         rsx.complete(_loc1_.rsx);
         font.complete(_loc1_.font);
         hero.complete(_loc1_.hero);
         inventory.complete(_loc1_.inventory);
         battleground.complete(_loc1_.battleground);
         skillIcon.complete(_loc1_.skillIcon);
         sound.init(rsx.game_sound);
      }
      
      public function getAssetFile(param1:String) : AssetFile
      {
         if(DevAssetRemaping.map && DevAssetRemaping.map[param1])
         {
            param1 = DevAssetRemaping.map[param1];
         }
         return index.getAssetFile(param1);
      }
   }
}
