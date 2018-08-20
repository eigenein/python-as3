package game.mediator.gui.tooltip
{
   public class TooltipVO
   {
      
      public static const HINT_BEHAVIOR_STATIC:String = "TooltipVO.HINT_BEHAVIOR_STATIC";
      
      public static const HINT_BEHAVIOR_STATIC_INTERACTIVE:String = "TooltipVO.HINT_BEHAVIOR_STATIC_INTERACTIVE";
      
      public static const HINT_BEHAVIOR_MOVING:String = "TooltipVO.HINT_BEHAVIOR_MOVING";
      
      public static const HINT_POSITION_DEFAULT:int = 0;
      
      public static const HINT_POSITION_MOUSE:int = 1;
      
      public static const TIMEOUT_NORMAL:int = 250;
      
      public static const TIMEOUT_IMMEDIATE:int = 0;
       
      
      public var behavior:String = "TooltipVO.HINT_BEHAVIOR_MOVING";
      
      public var position:int = 0;
      
      public var placeFn:Function;
      
      public var showTimeout:int = 250;
      
      public var hideTimeout:int = 0;
      
      public var hintClass:Class;
      
      public var hintData;
      
      public function TooltipVO(param1:Class, param2:*, param3:String = "TooltipVO.HINT_BEHAVIOR_MOVING")
      {
         super();
         hintClass = param1;
         hintData = param2;
         behavior = param3;
      }
   }
}
