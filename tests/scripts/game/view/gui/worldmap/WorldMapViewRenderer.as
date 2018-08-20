package game.view.gui.worldmap
{
   import com.progrestar.common.lang.Translate;
   import engine.context.GameContext;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.clipgui.GuiClipFactory;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.data.storage.pve.mission.MissionDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.worldmap.WorldMapEasterEggMediator;
   import game.mediator.gui.worldmap.WorldMapListValueObject;
   import game.mediator.gui.worldmap.WorldMapViewMissionValueObject;
   import game.model.GameModel;
   import game.model.user.specialoffer.Halloween2k17SpecialOfferViewOwner;
   import game.view.gui.components.ClipButtonBase;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   
   public class WorldMapViewRenderer extends ListItemRenderer
   {
       
      
      private var asset:RsxGameAsset;
      
      private var mapClip:WorldMapGuiClip;
      
      private var loadStarted:Boolean;
      
      private var progressbar:ClipProgressBar;
      
      private var assetProgress:AssetProgressProvider;
      
      private var worldMapSecretMediator:WorldMapEasterEggMediator;
      
      private var _signal_loaded:Signal;
      
      private var _map:WorldMapListValueObject;
      
      public function WorldMapViewRenderer()
      {
         _signal_loaded = new Signal();
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         .super.data = param1;
         index = map.desc.id;
      }
      
      override public function dispose() : void
      {
         if(assetProgress)
         {
            assetProgress.dispose();
         }
         if(mapClip)
         {
            mapClip.dispose();
         }
         if(worldMapSecretMediator)
         {
            worldMapSecretMediator.dispose();
         }
         super.dispose();
      }
      
      public function get signal_loaded() : Signal
      {
         return _signal_loaded;
      }
      
      public function get map() : WorldMapListValueObject
      {
         return data as WorldMapListValueObject;
      }
      
      public function getButtonByMission(param1:MissionDescription) : ClipButtonBase
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(!mapClip)
         {
            return null;
         }
         _loc3_ = mapClip.major_button_list.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = mapClip.major_button_list[_loc4_];
            if(_loc2_.data && _loc2_.data.mission == param1)
            {
               return _loc2_;
            }
            _loc4_++;
         }
         _loc3_ = mapClip.minor_button_list.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = mapClip.minor_button_list[_loc4_];
            if(_loc2_.data && _loc2_.data.mission == param1)
            {
               return _loc2_;
            }
            _loc4_++;
         }
         _loc3_ = mapClip.parallel_button_list.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = mapClip.parallel_button_list[_loc4_];
            if(_loc2_.data && _loc2_.data.mission == param1)
            {
               return _loc2_;
            }
            _loc4_++;
         }
         return null;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         width = 1000;
         height = 640;
      }
      
      public function show() : void
      {
         visible = true;
         if(mapClip)
         {
            mapClip.startAnimation();
         }
         if(!loadStarted)
         {
            asset = map.asset;
            if(asset.completed)
            {
               _initialize();
            }
            else
            {
               progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
               addChild(progressbar.graphics);
               progressbar.graphics.x = int((width - progressbar.graphics.width) / 2);
               progressbar.graphics.y = int((height - progressbar.graphics.height) / 2);
               AssetStorage.instance.globalLoader.requestAssetWithCallback(asset,handler_assetLoaded);
               assetProgress = AssetStorage.instance.globalLoader.getAssetProgress(asset);
               if(!assetProgress.completed)
               {
                  assetProgress.signal_onProgress.add(handler_assetProgress);
                  handler_assetProgress(assetProgress);
               }
            }
            loadStarted = true;
         }
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
      
      public function hide() : void
      {
         visible = false;
         if(mapClip)
         {
            mapClip.stopAnimation();
         }
      }
      
      protected function _initialize() : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc1_:* = null;
         _loc1_ = null;
         var _loc8_:* = null;
         _loc8_ = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         mapClip = new WorldMapGuiClip();
         var _loc2_:WorldMapRegionGuiClipFactory = new WorldMapRegionGuiClipFactory();
         _loc2_.createWorldMap(mapClip,asset.data.getClipByName(map.desc.assetClass));
         _loc3_ = mapClip.major_button_list.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = mapClip.major_button_list[_loc6_];
            _loc5_.signal_click.add(handler_missionClick);
            _loc6_++;
         }
         _loc3_ = mapClip.minor_button_list.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc1_ = mapClip.minor_button_list[_loc6_];
            _loc1_.signal_click.add(handler_missionClick);
            _loc6_++;
         }
         _loc3_ = mapClip.parallel_button_list.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc1_ = mapClip.minor_button_list[_loc6_];
            _loc1_.signal_click.add(handler_missionClick);
            _loc6_++;
         }
         addChild(mapClip.graphics);
         setButtonData();
         if(mapClip.layout_special_offer && mapClip.layout_special_offer.parent)
         {
            if(map.desc.id == 6)
            {
               _loc8_ = new Halloween2k17SpecialOfferViewOwner(mapClip.layout_special_offer,this,"worldmap6");
               GameModel.instance.player.specialOffer.hooks.registerHalloween2k17SpecialOffer(_loc8_);
            }
            else
            {
               _loc8_ = new Halloween2k17SpecialOfferViewOwner(mapClip.layout_special_offer,this,"worldmap");
               GameModel.instance.player.specialOffer.hooks.registerHalloween2k17SpecialOffer(_loc8_);
            }
         }
         if(map.desc.id == 9)
         {
            _loc4_ = new GuiClipFactory();
            worldMapSecretMediator = new WorldMapEasterEggMediator(map.easterEggData);
            _loc7_ = new WorldMapEasterEggGuiClip(worldMapSecretMediator);
            _loc4_.create(_loc7_,asset.data.getClipByName("secret"));
            addChild(_loc7_.graphics);
         }
         if(map.desc.id > 13 && !GameContext.instance.consoleEnabled)
         {
            PopupList.instance.error(Translate.translate("UI_WORLDMAP_LOCK"),"",true);
         }
         _signal_loaded.dispatch();
      }
      
      private function setButtonData() : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         _loc2_ = mapClip.major_button_list.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = mapClip.major_button_list[_loc5_];
            _loc6_ = map.getValueObject(_loc4_.index,true);
            _loc4_.data = _loc6_;
            _loc5_++;
         }
         _loc2_ = mapClip.minor_button_list.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc1_ = mapClip.minor_button_list[_loc5_];
            _loc6_ = map.getValueObject(_loc1_.index,false);
            _loc1_.data = _loc6_;
            _loc5_++;
         }
         _loc2_ = mapClip.parallel_button_list.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = mapClip.parallel_button_list[_loc5_];
            _loc6_ = map.getValueObject(_loc3_.index,false,true);
            _loc3_.data = _loc6_;
            _loc5_++;
         }
      }
      
      private function handler_assetLoaded(param1:RsxGameAsset) : void
      {
         _initialize();
      }
      
      private function handler_missionClick(param1:WorldMapMissionButton) : void
      {
         map.action_selectMission(param1.data);
      }
   }
}
