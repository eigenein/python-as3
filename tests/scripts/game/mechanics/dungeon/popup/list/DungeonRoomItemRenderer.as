package game.mechanics.dungeon.popup.list
{
   import flash.utils.getTimer;
   import game.mechanics.dungeon.mediator.DungeonFloorValueObject;
   import game.mechanics.dungeon.model.state.DungeonFloorBattleState;
   import game.mechanics.dungeon.popup.floor.DungeonBattleFloorClip;
   import game.mechanics.dungeon.popup.floor.DungeonBattleFloorWithStairsClip;
   import game.mechanics.dungeon.popup.floor.DungeonEntranceFloorClip;
   import game.mechanics.dungeon.popup.floor.DungeonFloorClipBase;
   import game.mechanics.dungeon.popup.floor.DungeonLeverFloorClip;
   import game.view.gui.components.list.ListItemRenderer;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public class DungeonRoomItemRenderer extends ListItemRenderer
   {
      
      public static const EVENT_SAVE_PROGRESS:String = "DungeonRoomItemRenderer.EVENT_SAVE_PROGRESS";
       
      
      private var _floor:DungeonFloorValueObject;
      
      private var floorClip:DungeonFloorClipBase;
      
      private var frontSprite:Sprite;
      
      public function DungeonRoomItemRenderer()
      {
         frontSprite = new Sprite();
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(_floor)
         {
            _floor.state_battle.unsubscribe(handler_battleStateChange);
            _floor.state_saveIsCaptured.unsubscribe(handler_saveIsCaptured);
            _floor.state_saveCanBeCaptured.unsubscribe(handler_saveCanBeCaptured);
            _floor.property_isCurrent.unsubscribe(handler_isCurrent);
            _floor.signal_playBridge.remove(handler_playBridge);
            _floor.signal_animateSave.remove(handler_animateSave);
            removeChild(floorClip.graphics);
            floorClip.dispose();
            floorClip = null;
         }
         if(frontSprite)
         {
            frontSprite.removeChildren(0,-1,true);
         }
         .super.data = param1;
         _floor = param1 as DungeonFloorValueObject;
         if(_floor)
         {
            floorClip = _floor.createAsset();
            addChild(floorClip.graphics);
            if(_floor.desc)
            {
               _floor.signal_playBridge.add(handler_playBridge);
               floorClip.floor_number.text = _floor.number.toString();
               floorClip.floor_number.adjustSizeToFitWidth();
               _loc2_ = floorClip as DungeonBattleFloorClip;
               if(_loc2_)
               {
                  _loc2_.createBattleButton(_floor);
                  if(_loc2_.getBattleDisplayClip())
                  {
                     _loc2_.getBattleDisplayClip().getBattleButton().signal_click.add(handler_battleClick);
                  }
                  _loc3_ = floorClip as DungeonBattleFloorWithStairsClip;
                  if(_loc3_)
                  {
                     frontSprite.addChild(_loc3_.frontContainer);
                  }
               }
               _loc4_ = floorClip as DungeonLeverFloorClip;
               if(_loc4_)
               {
                  _loc4_.save_display_button.button.signal_click.add(handler_saveClick);
               }
               _floor.state_battle.onValue(handler_battleStateChange);
               _floor.state_saveIsCaptured.onValue(handler_saveIsCaptured);
               _floor.state_saveCanBeCaptured.onValue(handler_saveCanBeCaptured);
               _floor.property_isCurrent.signal_update.add(handler_isCurrent);
               _floor.signal_animateSave.add(handler_animateSave);
               if(_floor.saveAnimationStartTime)
               {
                  setSaveAnimationStartTime(_floor.saveAnimationStartTime);
               }
               initIsCurrent(_floor.property_isCurrent.value);
            }
         }
      }
      
      public function get frontDisplayObject() : DisplayObject
      {
         return frontSprite;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         width = 1000;
         height = 490;
      }
      
      private function handler_animateSave() : void
      {
         var _loc2_:DungeonEntranceFloorClip = floorClip as DungeonEntranceFloorClip;
         if(_loc2_)
         {
            _loc2_.animateSave();
         }
         var _loc1_:DungeonLeverFloorClip = floorClip as DungeonLeverFloorClip;
         if(_loc1_)
         {
            _loc1_.animateSave();
         }
      }
      
      private function setSaveAnimationStartTime(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = getTimer();
         var _loc5_:DungeonEntranceFloorClip = floorClip as DungeonEntranceFloorClip;
         if(_loc5_)
         {
            _loc3_ = _loc5_.animationDuration * 1000;
            if(param1 + _loc3_ > _loc2_)
            {
               _loc5_.animateSave(_loc2_ - param1);
            }
            else
            {
               _loc5_.action_setSaveIsCaptured(true);
            }
         }
         var _loc4_:DungeonLeverFloorClip = floorClip as DungeonLeverFloorClip;
         if(_loc4_)
         {
            _loc3_ = _loc4_.animationDuration * 1000;
            if(param1 + _loc3_ > _loc2_)
            {
               _loc4_.animateSave(_loc2_ - param1);
            }
            else
            {
               _loc5_.action_setSaveIsCaptured(true);
            }
         }
      }
      
      private function handler_playBridge() : void
      {
         floorClip.action_playBridgeAnimation(_floor.rightExit);
      }
      
      private function initIsCurrent(param1:Boolean) : void
      {
         var _loc2_:DungeonBattleFloorWithStairsClip = floorClip as DungeonBattleFloorWithStairsClip;
         if(_loc2_)
         {
            if(_floor.isRightmost && !_floor.rightExit || _floor.isLeftmost && _floor.rightExit)
            {
               _loc2_.tweenStairsGlowOff(10);
            }
            else
            {
               _loc2_.turnStairsGlowOff();
            }
         }
      }
      
      private function handler_battleClick() : void
      {
         dispatchDataEvent("ListItemRenderer.EVENT_SELECT");
      }
      
      private function handler_saveClick() : void
      {
         dispatchDataEvent("DungeonRoomItemRenderer.EVENT_SAVE_PROGRESS");
      }
      
      private function handler_battleStateChange(param1:DungeonFloorBattleState) : void
      {
         var _loc2_:DungeonBattleFloorClip = floorClip as DungeonBattleFloorClip;
         if(_loc2_)
         {
            _loc2_.getBattleDisplayClip().setState(param1);
            _loc2_.getBattleDisplayClip().setElements(_floor.elements);
         }
      }
      
      private function handler_saveCanBeCaptured(param1:Boolean) : void
      {
         var _loc2_:DungeonLeverFloorClip = floorClip as DungeonLeverFloorClip;
         if(_loc2_)
         {
            _loc2_.action_saveCanBeCaptured(param1);
         }
      }
      
      private function handler_saveIsCaptured(param1:Boolean) : void
      {
         var _loc3_:DungeonEntranceFloorClip = floorClip as DungeonEntranceFloorClip;
         if(_loc3_)
         {
            _loc3_.action_setSaveIsCaptured(param1);
         }
         var _loc2_:DungeonLeverFloorClip = floorClip as DungeonLeverFloorClip;
         if(_loc2_)
         {
            _loc2_.action_setSaveIsCaptured(param1);
         }
      }
      
      private function handler_isCurrent(param1:Boolean) : void
      {
         var _loc2_:DungeonBattleFloorWithStairsClip = floorClip as DungeonBattleFloorWithStairsClip;
         if(_loc2_)
         {
            if(!param1 && (_floor.isRightmost && _floor.rightExit || _floor.isLeftmost && !_floor.rightExit))
            {
               _loc2_.tweenStairsGlowOn(1);
            }
            else if(param1 && (_floor.isRightmost && !_floor.rightExit || _floor.isLeftmost && _floor.rightExit))
            {
               _loc2_.tweenStairsGlowOff(10);
            }
            else
            {
               _loc2_.turnStairsGlowOff();
            }
         }
      }
   }
}
