package vk
{
   import flash.events.Event;
   
   public final dynamic class APIEvent extends Event
   {
      
      public static const INITIALIZED:String = "onInitialized";
      
      public static const APPLICATION_ADDED:String = "onApplicationAdded";
      
      public static const SETTINGS_CHANGED:String = "onSettingsChanged";
      
      public static const BALANCE_CHANGED:String = "onBalanceChanged";
      
      public static const ORDER_CANCEL:String = "onOrderCancel";
      
      public static const ORDER_SUCCESS:String = "onOrderSuccess";
      
      public static const ORDER_FAIL:String = "onOrderFail";
      
      public static const PROFILE_PHOTO_SAVE:String = "onProfilePhotoSave";
      
      public static const WALL_POST_SAVE:String = "onWallPostSave";
      
      public static const WALL_POST_CANCEL:String = "onWallPostCancel";
      
      public static const WINDOW_RESIZED:String = "onWindowResized";
      
      public static const LOCATION_CHANGED:String = "onLocationChanged";
      
      public static const WINDOW_BLUR:String = "onWindowBlur";
      
      public static const WINDOW_FOCUS:String = "onWindowFocus";
      
      public static const SCROLL_TOP:String = "onScrollTop";
      
      public static const SCROLL:String = "onScroll";
      
      public static const TOGGLE_FLASH:String = "onToggleFlash";
      
      public static const SUBSCRIPTION_SUCCESS:String = "onSubscriptionSuccess";
      
      public static const SUBSCRIPTION_CANCEL:String = "onSubscriptionFail";
      
      public static const SUBSCRIPTION_FAIL:String = "onSubscriptionCancel";
      
      public static const REQUEST_SUCCESS:String = "onRequestSuccess";
      
      public static const REQUEST_CANCEL:String = "onRequestCancel";
      
      public static const REQUEST_FAIL:String = "onRequestFail";
       
      
      public var settings:int;
      
      public var balance:int;
      
      public var orderId:int;
      
      public var errorCode:int;
      
      public var width:int;
      
      public var height:int;
      
      public var scrollTop:int;
      
      public var windowHeigth:int;
      
      public var show:Boolean;
      
      public var requestId:int;
      
      public function APIEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2 != null)
         {
            var _loc7_:int = 0;
            var _loc6_:* = param2;
            for(var _loc5_ in param2)
            {
               this[_loc5_] = param2[_loc5_];
            }
         }
      }
      
      override public function clone() : Event
      {
         var _loc1_:APIEvent = new APIEvent(null,type,bubbles,cancelable);
         var _loc4_:int = 0;
         var _loc3_:* = this;
         for(var _loc2_ in this)
         {
            _loc1_[_loc2_] = this[_loc2_];
         }
         return _loc1_;
      }
   }
}
