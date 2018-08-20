package feathers.core
{
   import flash.utils.Dictionary;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class PopUpManager
   {
      
      protected static const _starlingToPopUpManager:Dictionary = new Dictionary(true);
      
      public static var popUpManagerFactory:Function = defaultPopUpManagerFactory;
       
      
      public function PopUpManager()
      {
         super();
      }
      
      public static function defaultPopUpManagerFactory() : IPopUpManager
      {
         return new DefaultPopUpManager();
      }
      
      public static function forStarling(param1:Starling) : IPopUpManager
      {
         var _loc3_:* = null;
         if(!param1)
         {
            throw new ArgumentError("PopUpManager not found. Starling cannot be null.");
         }
         var _loc2_:IPopUpManager = _starlingToPopUpManager[param1];
         if(!_loc2_)
         {
            _loc3_ = PopUpManager.popUpManagerFactory;
            if(_loc3_ === null)
            {
               _loc3_ = PopUpManager.defaultPopUpManagerFactory;
            }
            _loc2_ = _loc3_();
            PopUpManager._starlingToPopUpManager[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function get overlayFactory() : Function
      {
         return PopUpManager.forStarling(Starling.current).overlayFactory;
      }
      
      public static function set overlayFactory(param1:Function) : void
      {
         PopUpManager.forStarling(Starling.current).overlayFactory = param1;
      }
      
      public static function defaultOverlayFactory() : DisplayObject
      {
         return DefaultPopUpManager.defaultOverlayFactory();
      }
      
      public static function get root() : DisplayObjectContainer
      {
         return PopUpManager.forStarling(Starling.current).root;
      }
      
      public static function set root(param1:DisplayObjectContainer) : void
      {
         PopUpManager.forStarling(Starling.current).root = param1;
      }
      
      public static function addPopUp(param1:DisplayObject, param2:Boolean = true, param3:Boolean = true, param4:Function = null) : DisplayObject
      {
         return PopUpManager.forStarling(Starling.current).addPopUp(param1,param2,param3,param4);
      }
      
      public static function removePopUp(param1:DisplayObject, param2:Boolean = false) : DisplayObject
      {
         return PopUpManager.forStarling(Starling.current).removePopUp(param1,param2);
      }
      
      public static function isPopUp(param1:DisplayObject) : Boolean
      {
         return PopUpManager.forStarling(Starling.current).isPopUp(param1);
      }
      
      public static function isTopLevelPopUp(param1:DisplayObject) : Boolean
      {
         return PopUpManager.forStarling(Starling.current).isTopLevelPopUp(param1);
      }
      
      public static function centerPopUp(param1:DisplayObject) : void
      {
         PopUpManager.forStarling(Starling.current).centerPopUp(param1);
      }
   }
}
