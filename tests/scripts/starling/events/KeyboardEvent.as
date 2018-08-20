package starling.events
{
   public class KeyboardEvent extends Event
   {
      
      public static const KEY_UP:String = "keyUp";
      
      public static const KEY_DOWN:String = "keyDown";
       
      
      private var mCharCode:uint;
      
      private var mKeyCode:uint;
      
      private var mKeyLocation:uint;
      
      private var mAltKey:Boolean;
      
      private var mCtrlKey:Boolean;
      
      private var mShiftKey:Boolean;
      
      private var mIsDefaultPrevented:Boolean;
      
      public function KeyboardEvent(param1:String, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,false,param3);
         mCharCode = param2;
         mKeyCode = param3;
         mKeyLocation = param4;
         mCtrlKey = param5;
         mAltKey = param6;
         mShiftKey = param7;
      }
      
      public function preventDefault() : void
      {
         mIsDefaultPrevented = true;
      }
      
      public function isDefaultPrevented() : Boolean
      {
         return mIsDefaultPrevented;
      }
      
      public function get charCode() : uint
      {
         return mCharCode;
      }
      
      public function get keyCode() : uint
      {
         return mKeyCode;
      }
      
      public function get keyLocation() : uint
      {
         return mKeyLocation;
      }
      
      public function get altKey() : Boolean
      {
         return mAltKey;
      }
      
      public function get ctrlKey() : Boolean
      {
         return mCtrlKey;
      }
      
      public function get shiftKey() : Boolean
      {
         return mShiftKey;
      }
   }
}
