package feathers.events
{
   public class FeathersEventType
   {
      
      public static const INITIALIZE:String = "initialize";
      
      public static const CREATION_COMPLETE:String = "creationComplete";
      
      public static const RESIZE:String = "resize";
      
      public static const ENTER:String = "enter";
      
      public static const CLEAR:String = "clear";
      
      public static const SCROLL_START:String = "scrollStart";
      
      public static const SCROLL_COMPLETE:String = "scrollComplete";
      
      public static const BEGIN_INTERACTION:String = "beginInteraction";
      
      public static const END_INTERACTION:String = "endInteraction";
      
      public static const TRANSITION_START:String = "transitionStart";
      
      public static const TRANSITION_COMPLETE:String = "transitionComplete";
      
      public static const FOCUS_IN:String = "focusIn";
      
      public static const FOCUS_OUT:String = "focusOut";
      
      public static const RENDERER_ADD:String = "rendererAdd";
      
      public static const RENDERER_REMOVE:String = "rendererRemove";
      
      public static const ERROR:String = "error";
      
      public static const LAYOUT_DATA_CHANGE:String = "layoutDataChange";
      
      public static const LONG_PRESS:String = "longPress";
      
      public static const SOFT_KEYBOARD_ACTIVATE:String = "softKeyboardActivate";
      
      public static const SOFT_KEYBOARD_DEACTIVATE:String = "softKeyboardDeactivate";
       
      
      public function FeathersEventType()
      {
         super();
      }
   }
}
