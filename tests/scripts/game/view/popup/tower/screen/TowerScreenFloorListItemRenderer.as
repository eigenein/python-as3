package game.view.popup.tower.screen
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.tower.TowerFloorValueObject;
   import game.model.GameModel;
   import game.model.user.specialoffer.Halloween2k17SpecialOfferViewOwner;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   
   public class TowerScreenFloorListItemRenderer extends ListItemRenderer
   {
       
      
      private var towerFloorValkyrieClipButton:TowerFloorValkyrieClipButton;
      
      private var floorClip:TowerScreenFloorListItemRendererClip;
      
      private var _signal_select:Signal;
      
      private var _signal_nextFloor:Signal;
      
      public function TowerScreenFloorListItemRenderer()
      {
         _signal_select = new Signal(TowerFloorValueObject);
         _signal_nextFloor = new Signal(TowerFloorValueObject);
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function get floor() : TowerFloorValueObject
      {
         return _data as TowerFloorValueObject;
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get signal_nextFloor() : Signal
      {
         return _signal_nextFloor;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:TowerFloorValueObject = _data as TowerFloorValueObject;
         if(_loc2_)
         {
            _loc2_.signal_update.remove(handler_floorDataUpdate);
            _loc2_.signal_heroEnter.remove(handler_heroEnter);
            _loc2_.signal_heroHide.remove(handler_heroHide);
            _loc2_.signal_heroExit.remove(handler_heroExit);
            removeChild(floorClip.graphics);
            floorClip.dispose();
            floorClip = null;
         }
         .super.data = param1;
         _loc2_ = param1 as TowerFloorValueObject;
         if(_loc2_)
         {
            floorClip = _loc2_.createAsset();
            addChild(floorClip.graphics);
            if(floorClip.layout_special_offer.parent)
            {
               registerSpecialOfferSpot(floorClip.layout_special_offer);
            }
            if(_loc2_.desc)
            {
               floorClip.closeExitDoor();
               _loc2_.signal_update.add(handler_floorDataUpdate);
               floorClip.floor_number.text = _loc2_.number.toString();
               floorClip.button.signal_click.add(handler_buttonClick);
               if(floorClip.button_arrow)
               {
                  floorClip.button_arrow.signal_click.add(handler_arrowClick);
               }
               _loc2_.signal_heroEnter.add(handler_heroEnter);
               _loc2_.signal_heroHide.add(handler_heroHide);
               _loc2_.signal_heroExit.add(handler_heroExit);
               if(_loc2_.canAddValkyrie)
               {
                  towerFloorValkyrieClipButton = AssetStorage.rsx.tower_floors.create(TowerFloorValkyrieClipButton,"button_valkyrie");
                  towerFloorValkyrieClipButton.signal_click.add(handler_buttonClick);
                  towerFloorValkyrieClipButton.graphics.x = 300;
                  towerFloorValkyrieClipButton.graphics.y = 20;
                  floorClip.container.addChild(towerFloorValkyrieClipButton.graphics);
               }
               updateButtons();
            }
         }
      }
      
      public function registerSpecialOfferSpot(param1:ClipLayout) : void
      {
         var _loc2_:Halloween2k17SpecialOfferViewOwner = new Halloween2k17SpecialOfferViewOwner(param1,this,"tower50");
         GameModel.instance.player.specialOffer.hooks.registerHalloween2k17SpecialOffer(_loc2_);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         width = 1000;
         height = 334;
      }
      
      private function updateButtons() : void
      {
         var _loc1_:TowerFloorValueObject = _data as TowerFloorValueObject;
         if(_loc1_.canAddValkyrie)
         {
            floorClip.button.isEnabled = false;
         }
         else
         {
            floorClip.button.isEnabled = _loc1_.canInteract;
         }
         if(floorClip.button_arrow)
         {
            floorClip.button_arrow.graphics.visible = _loc1_.canProceed;
            if(!_loc1_.canProceed)
            {
            }
         }
      }
      
      private function handler_buttonClick() : void
      {
         _signal_select.dispatch(data as TowerFloorValueObject);
      }
      
      private function handler_arrowClick() : void
      {
         _signal_nextFloor.dispatch(data as TowerFloorValueObject);
      }
      
      private function handler_floorDataUpdate() : void
      {
         updateButtons();
      }
      
      private function handler_heroHide() : void
      {
         TowerFloorValueObject.screenHero.action_gentlyHideHeroes();
      }
      
      private function handler_heroEnter() : void
      {
         floorClip.hero_container.container.addChild(TowerFloorValueObject.screenHero.graphics);
         if(floor.rightExit)
         {
            TowerFloorValueObject.screenHero.action_moveFromLeft();
         }
         else
         {
            TowerFloorValueObject.screenHero.action_moveFromRight();
         }
         updateButtons();
      }
      
      private function handler_heroExit(param1:int) : void
      {
         if(param1 == 0)
         {
            if(floor.rightExit)
            {
               TowerFloorValueObject.screenHero.action_moveToRight();
            }
            else
            {
               TowerFloorValueObject.screenHero.action_moveToLeft();
            }
            floorClip.hero_container.container.addChild(TowerFloorValueObject.screenHero.graphics);
            floorClip.openExitDoor();
         }
         else
         {
            floorClip.closeExitDoor();
         }
      }
   }
}
