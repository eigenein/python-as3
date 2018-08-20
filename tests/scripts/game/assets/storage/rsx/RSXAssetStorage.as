package game.assets.storage.rsx
{
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import feathers.textures.Scale3Textures;
   import feathers.textures.Scale9Textures;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetTypeStorage;
   import game.assets.storage.RsxGameAsset;
   import game.view.gui.worldmap.WorldMapGUIAsset;
   import game.view.popup.theme.RsxPopupTheme;
   import starling.textures.Texture;
   import starling.textures.TextureMemoryManager;
   
   public class RSXAssetStorage extends AssetTypeStorage
   {
       
      
      public var missing:Texture;
      
      public var missingScale3:Scale3Textures;
      
      public var missingScale9:Scale9Textures;
      
      private var assetsAllowedToBeDisposed:Dictionary;
      
      private var _initMap:Dictionary;
      
      public const clan_war_map:RsxGuiAsset = register(new RsxGuiAsset("clan_war_map"));
      
      public const asset_bundle:RsxGuiAsset = register(new RsxGuiAsset("asset_bundle"));
      
      public const bundle_icons:RsxGuiAsset = register(new RsxGuiAsset("bundle_icons"));
      
      public const dungeon_floors:DungeonFloorsAsset = register(new DungeonFloorsAsset("dungeon_floors"));
      
      public const clan_icons:RsxClanIconsAsset = register(new RsxClanIconsAsset("clan_icons"));
      
      public const tower_floors:TowerFloorsAsset = register(new TowerFloorsAsset("tower_floors"));
      
      public const birth_day_graphics:BirthDayGraphicsAsset = register(new BirthDayGraphicsAsset("offer_birthday"));
      
      public const chest_graphics:ChestGraphicsAsset = register(new ChestGraphicsAsset("chest_graphics"));
      
      public const event_chest_graphics:EventChestGraphicsAsset = register(new EventChestGraphicsAsset("chest_graphics_ny"));
      
      public const easter_graphics:RsxGuiAsset = register(new RsxGuiAsset("easter_graphics"));
      
      public const dialog_battle_defeat:DialogBattleDefeatAsset = register(new DialogBattleDefeatAsset(DialogBattleDefeatAsset.IDENT));
      
      public const world_map:WorldMapGUIAsset = register(new WorldMapGUIAsset("world_map"));
      
      public const popup_theme:RsxPopupTheme = register(new RsxPopupTheme("dialog_basic"));
      
      public const dialog_test_battle:RsxGuiAsset = register(new RsxGuiAsset("dialog_test_battle"));
      
      public const titan_artifact_chest_graphics:RsxGuiAsset = register(new RsxGuiAsset("titan_artifact_chest_graphics"));
      
      public const dialog_titan_arena:RsxGuiAsset = register(new RsxGuiAsset("dialog_titan_arena"));
      
      public const game_sound:RsxGuiAsset = register(new RsxGuiAsset("game_sound"));
      
      public const rune_icons:RsxRuneIconAsset = register(new RsxRuneIconAsset("rune_icons"));
      
      public const boss_icons:RsxGuiAsset = register(new RsxGuiAsset("boss_icons"));
      
      public const battle_interface:BattleGUIAsset = register(new BattleGUIAsset("battle_interface"));
      
      public const dialog_tutorial:TutorialGuiAsset = register(new TutorialGuiAsset("dialog_tutorial"));
      
      public const main_screen:RsxGuiAsset = register(new RsxGuiAsset("main_screen"));
      
      public const clan_screen:RsxGuiAsset = register(new RsxGuiAsset("clan_screen"));
      
      public const odnoklassniki_sale_banner:RsxGuiAsset = register(new RsxGuiAsset("odnoklassniki_sale_banner"));
      
      public const dialog_boss:RsxGuiAsset = register(new RsxGuiAsset("dialog_boss"));
      
      public const bundle_3:RsxGuiAsset = register(new RsxGuiAsset("bundle_3"));
      
      public const asset_clan_circle:RsxGuiAsset = register(new RsxGuiAsset("clan_circle"));
      
      public const titan_icons:RsxGuiAsset = register(new RsxGuiAsset("titan_icons"));
      
      public const event_icons:RsxGuiAsset = register(new RsxGuiAsset("event_icons"));
      
      public const artifact_icons_large:RsxGuiAsset = register(new RsxGuiAsset("artifact_icons_large"));
      
      public const titan_artifact_icons_large:RsxGuiAsset = register(new RsxGuiAsset("titan_artifact_icons_large"));
      
      public const artifact_icons:RsxGuiAsset = register(new RsxGuiAsset("artifact_icons"));
      
      public const titan_artifact_icons:RsxGuiAsset = register(new RsxGuiAsset("titan_artifact_icons"));
      
      public const dialog_expedition:RsxGuiAsset = register(new RsxGuiAsset("dialog_expedition_map"));
      
      public const dialog_artifact_subscription:RsxGuiAsset = register(new RsxGuiAsset("dialog_artifact_subscription"));
      
      public const dialog_zeppelin:RsxGuiAsset = register(new RsxGuiAsset("dialog_zeppelin"));
      
      public const dialog_artifact_chest:RsxGuiAsset = register(new RsxGuiAsset("dialog_artifact_chest"));
      
      public const artifact_graphics:RsxGuiAsset = register(new RsxGuiAsset("artifact_graphics"));
      
      public const big_pillars:RsxGuiAsset = register(new RsxGuiAsset("big_pillars"));
      
      public const ny_gifts:RsxGuiAsset = register(new RsxGuiAsset("ny_gifts"));
      
      public function RSXAssetStorage(param1:* = null)
      {
         assetsAllowedToBeDisposed = new Dictionary();
         _initMap = new Dictionary();
         super(param1);
         TextureMemoryManager.signal_memoryAlarm.add(handler_memoryAlarm);
      }
      
      public function getByName(param1:String) : RsxGameAsset
      {
         return dict[param1] as RsxGameAsset;
      }
      
      public function getGuiByName(param1:String) : RsxGuiAsset
      {
         return dict[param1] as RsxGuiAsset;
      }
      
      public function createClip(param1:String, param2:Class, param3:String) : *
      {
         return (dict[param1] as RsxGuiAsset).create(param2,param3);
      }
      
      public function getTexture(param1:String, param2:String) : Texture
      {
         var _loc3_:* = null;
         var _loc4_:RsxGameAsset = dict[param2] as RsxGameAsset;
         if(_loc4_)
         {
            _loc3_ = _loc4_.getTexture(param1);
            if(_loc3_)
            {
               return _loc3_;
            }
         }
         return AssetStorage.rsx.missing;
      }
      
      override public function complete(param1:*) : void
      {
         missing = Texture.fromBitmapData(new BitmapData(100,100,true,2868838587));
         TextureMemoryManager.add(missing,"missing");
         missingScale3 = new Scale3Textures(missing,0,1);
         missingScale9 = new Scale9Textures(missing,new Rectangle(2,2,2,2));
         super.complete(param1);
      }
      
      public function getAssetsAllowedToBeDisposed() : String
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = assetsAllowedToBeDisposed;
         for(var _loc2_ in assetsAllowedToBeDisposed)
         {
            _loc1_.push(_loc2_.ident + ":" + _loc2_.used + (!!_loc2_.completed?"!":"-"));
         }
         return String(_loc1_);
      }
      
      public function allowAssetToBeDisposed(param1:RsxGameAsset) : void
      {
         assetsAllowedToBeDisposed[param1] = true;
      }
      
      public function disposeUnusedAssets() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = assetsAllowedToBeDisposed;
         for(var _loc1_ in assetsAllowedToBeDisposed)
         {
            if(_loc1_ is RsxGameAsset)
            {
               _loc2_ = _loc1_ as RsxGameAsset;
               if(_loc2_.completed && !_loc2_.mandatory && _loc2_.used == 0)
               {
                  _loc2_.dispose();
                  ClipImageCache.disposedAssetsList.push(_loc2_.ident);
               }
            }
         }
      }
      
      override public function init(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc3_ in param1)
         {
            _loc2_ = param1[_loc3_];
            if(_initMap[_loc3_])
            {
               _initMap[_loc3_].init(_loc2_);
               dict[_loc3_] = _initMap[_loc3_];
            }
            else if(_loc2_.gui)
            {
               dict[_loc3_] = new RsxGuiAsset(_loc2_);
            }
            else
            {
               dict[_loc3_] = new RsxGameAsset(_loc2_);
            }
         }
         _initMap = null;
      }
      
      protected function register(param1:RsxGameAsset) : *
      {
         var _loc2_:* = param1;
         _initMap[param1.ident] = _loc2_;
         return _loc2_;
      }
      
      private function handler_memoryAlarm() : void
      {
         disposeUnusedAssets();
      }
   }
}
