package game.mediator.gui.tooltip
{
   import flash.utils.Dictionary;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class TooltipHelper
   {
      
      private static var dict:Dictionary = new Dictionary();
       
      
      public function TooltipHelper()
      {
         super();
      }
      
      public static function addTooltip(param1:DisplayObject, param2:TooltipVO) : void
      {
         var _loc3_:* = null;
         if(!param1)
         {
            return;
         }
         if(dict[param1])
         {
            return;
         }
         _loc3_ = new TooltipProxy(param1,param2);
         dict[param1] = _loc3_;
         if(param1.stage)
         {
            TooltipLayerMediator.instance.addSource(_loc3_);
         }
         else
         {
            param1.addEventListener("addedToStage",handler_addedToStage);
         }
      }
      
      public static function getTooltipData(param1:DisplayObject) : TooltipVO
      {
         var _loc2_:TooltipProxy = dict[param1];
         if(_loc2_)
         {
            return _loc2_.tooltipVO;
         }
         return null;
      }
      
      public static function removeTooltip(param1:DisplayObject) : void
      {
         param1.removeEventListener("addedToStage",handler_addedToStage);
         var _loc2_:TooltipProxy = dict[param1];
         if(_loc2_)
         {
            TooltipLayerMediator.instance.removeSource(_loc2_);
            delete dict[param1];
         }
      }
      
      private static function handler_addedToStage(param1:Event) : void
      {
         var _loc2_:TooltipProxy = dict[param1.target as DisplayObject];
         if(_loc2_)
         {
            TooltipLayerMediator.instance.addSource(_loc2_);
         }
      }
      
      private static function handler_removedFromStage(param1:Event) : void
      {
         removeTooltip(param1.target as DisplayObject);
      }
   }
}
