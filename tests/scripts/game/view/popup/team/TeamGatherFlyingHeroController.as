package game.view.popup.team
{
   import feathers.controls.List;
   import flash.utils.getTimer;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import starling.display.DisplayObjectContainer;
   
   public class TeamGatherFlyingHeroController
   {
      
      public static const ANIMATION_DURATION_SELECT:Number = 0.2;
      
      public static const ANIMATION_DURATION_DESELECT:Number = 0.17;
       
      
      private var mediator:TeamGatherPopupMediator;
      
      private var flyingLayer:FlyingHeroIconLayer;
      
      private var heroList:List;
      
      private var teamList:List;
      
      private var inFrameCounter:int = 0;
      
      private var lastSelectTime:Number = 0;
      
      public function TeamGatherFlyingHeroController(param1:List, param2:List)
      {
         super();
         this.heroList = param1;
         this.teamList = param2;
         flyingLayer = new FlyingHeroIconLayer();
      }
      
      public function dispose() : void
      {
         mediator.signal_heroSelected.remove(handler_heroSelected);
         mediator.signal_heroDeselected.remove(handler_heroSelected);
         flyingLayer.dispose();
      }
      
      public function get graphics() : DisplayObjectContainer
      {
         return flyingLayer.graphics;
      }
      
      public function setup(param1:TeamGatherPopupMediator) : void
      {
         param1.signal_heroSelected.add(handler_heroSelected);
         param1.signal_heroDeselected.add(handler_heroSelected);
         this.mediator = param1;
      }
      
      private function handler_heroSelected(param1:TeamGatherPopupHeroValueObject, param2:Number) : void
      {
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc6_:* = NaN;
         var _loc10_:* = NaN;
         var _loc13_:* = NaN;
         var _loc11_:* = NaN;
         var _loc7_:Number = NaN;
         var _loc12_:* = null;
         var _loc9_:* = null;
         teamList.validate();
         var _loc4_:DisplayObjectContainer = teamList.getChildAt(0) as DisplayObjectContainer;
         _loc8_ = 0;
         while(_loc8_ < _loc4_.numChildren)
         {
            _loc3_ = _loc4_.getChildAt(_loc8_) as TeamGatherPopupTeamMemberRenderer;
            if(_loc3_ && _loc3_.data && _loc3_.data.desc && _loc3_.data.desc.id == param1.desc.id)
            {
               _loc12_ = _loc3_;
               break;
            }
            _loc8_++;
         }
         heroList.validate();
         _loc4_ = heroList.getChildAt(0) as DisplayObjectContainer;
         _loc8_ = 0;
         while(_loc8_ < _loc4_.numChildren)
         {
            _loc3_ = _loc4_.getChildAt(_loc8_) as TeamGatherPopupTeamMemberRenderer;
            if(_loc3_ && _loc3_.data && _loc3_.data.desc && _loc3_.data.desc.id == param1.desc.id)
            {
               _loc9_ = _loc3_;
               break;
            }
            _loc8_++;
         }
         var _loc5_:Number = getTimer();
         if(param1.selected)
         {
            if(_loc5_ < lastSelectTime + 10)
            {
               inFrameCounter = Number(inFrameCounter) + 1;
            }
            else
            {
               inFrameCounter = 0;
            }
         }
         else
         {
            inFrameCounter = 0;
         }
         lastSelectTime = _loc5_;
         if(_loc12_ && _loc9_)
         {
            if(param1.selected)
            {
               _loc12_.animateSelection(param2);
               _loc6_ = 0.7;
               _loc10_ = 0.4;
               _loc13_ = 0.8;
               _loc11_ = NaN;
               _loc7_ = NaN;
               flyingLayer.add(param1.unitEntryVo,_loc9_,_loc12_,_loc6_,_loc10_,_loc13_,param2,_loc11_,_loc7_);
            }
            else
            {
               _loc6_ = 1.6;
               _loc10_ = 1.45;
               _loc13_ = 0.9;
               _loc11_ = -100;
               _loc7_ = -500;
               flyingLayer.add(param1.unitEntryVo,_loc12_,_loc9_,_loc6_,_loc10_,_loc13_,param2,_loc11_,_loc7_);
            }
         }
         else if(param1.selected)
         {
            _loc12_.animateSelection(param2);
         }
      }
   }
}
