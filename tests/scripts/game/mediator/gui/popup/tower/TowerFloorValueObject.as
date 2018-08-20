package game.mediator.gui.popup.tower
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.tower.TowerFloorDescription;
   import game.data.storage.tower.TowerFloorType;
   import game.model.user.tower.PlayerTowerFloor;
   import game.view.popup.tower.screen.TowerScreenBattleFloorClip;
   import game.view.popup.tower.screen.TowerScreenBuffFloorClip;
   import game.view.popup.tower.screen.TowerScreenChestFloorClip;
   import game.view.popup.tower.screen.TowerScreenFloorListItemRendererClip;
   import game.view.popup.tower.screen.TowerScreenHeroes;
   import idv.cjcat.signals.Signal;
   
   public class TowerFloorValueObject
   {
      
      public static const SIGNAL_START:int = 0;
      
      public static const SIGNAL_END:int = 1;
      
      public static var screenHero:TowerScreenHeroes;
       
      
      private var playerFloor:PlayerTowerFloor;
      
      private var _signal_heroEnter:Signal;
      
      private var _signal_heroExit:Signal;
      
      public const signal_heroHide:Signal = new Signal();
      
      private var _signal_update:Signal;
      
      private var _desc:TowerFloorDescription;
      
      public function TowerFloorValueObject(param1:TowerFloorDescription)
      {
         _signal_heroEnter = new Signal();
         _signal_heroExit = new Signal(int);
         _signal_update = new Signal();
         super();
         this._desc = param1;
      }
      
      public function dispose() : void
      {
         if(this.playerFloor)
         {
            this.playerFloor.signal_updateCanProceed.remove(handler_updateCanProceed);
         }
      }
      
      public function get signal_heroEnter() : Signal
      {
         return _signal_heroEnter;
      }
      
      public function get signal_heroExit() : Signal
      {
         return _signal_heroExit;
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function get canInteract() : Boolean
      {
         return playerFloor && playerFloor.canInteract;
      }
      
      public function get canProceed() : Boolean
      {
         return playerFloor && playerFloor.canProceed;
      }
      
      public function get canAddValkyrie() : Boolean
      {
         return playerFloor && playerFloor.canAddValkyrie;
      }
      
      public function get desc() : TowerFloorDescription
      {
         return _desc;
      }
      
      public function get number() : int
      {
         return !!desc?desc.floor:0;
      }
      
      public function get assetName() : String
      {
         if(!desc)
         {
            return "tower_floor_basement";
         }
         if(desc.floor == 50)
         {
            return "tower_floor_chest_top";
         }
         var _loc1_:String = "";
         var _loc2_:* = desc.type;
         if(TowerFloorType.BATTLE !== _loc2_)
         {
            if(TowerFloorType.BUFF !== _loc2_)
            {
               if(TowerFloorType.CHEST !== _loc2_)
               {
                  _loc1_ = "tower_floor_battle";
               }
               else if(desc.floor > 25)
               {
                  _loc1_ = "tower_floor_chest_XL";
               }
               else
               {
                  _loc1_ = "tower_floor_chest";
               }
            }
            else
            {
               _loc1_ = "tower_floor_buff";
            }
         }
         else
         {
            _loc1_ = "tower_floor_battle";
         }
         if(rightExit)
         {
            _loc1_ = _loc1_ + "_r";
         }
         return _loc1_;
      }
      
      public function get rightExit() : Boolean
      {
         return desc && desc.floor % 2 == 0;
      }
      
      public function setPlayerFloor(param1:PlayerTowerFloor) : void
      {
         if(this.playerFloor)
         {
            this.playerFloor.signal_updateCanProceed.remove(handler_updateCanProceed);
         }
         this.playerFloor = param1;
         _signal_update.dispatch();
         if(param1)
         {
            param1.signal_updateCanProceed.add(handler_updateCanProceed);
         }
      }
      
      private function handler_updateCanProceed() : void
      {
         _signal_update.dispatch();
      }
      
      public function createAsset() : TowerScreenFloorListItemRendererClip
      {
         if(desc)
         {
            var _loc1_:* = desc.type;
            if(TowerFloorType.BATTLE !== _loc1_)
            {
               if(TowerFloorType.BUFF !== _loc1_)
               {
                  if(TowerFloorType.CHEST === _loc1_)
                  {
                     return AssetStorage.rsx.tower_floors.create(TowerScreenChestFloorClip,assetName);
                  }
               }
               else
               {
                  return AssetStorage.rsx.tower_floors.create(TowerScreenBuffFloorClip,assetName);
               }
            }
            else
            {
               return AssetStorage.rsx.tower_floors.create(TowerScreenBattleFloorClip,assetName);
            }
         }
         return AssetStorage.rsx.tower_floors.create(TowerScreenFloorListItemRendererClip,assetName);
      }
   }
}
