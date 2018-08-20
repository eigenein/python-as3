package game.model.user.specialoffer.viewslot
{
   import engine.core.utils.TypeUtil;
   import game.mechanics.clientoffer.popup.ViewSlotOneTimeTextAnimation;
   import game.mechanics.clientoffer.popup.ViewSlotStaticText;
   import game.model.user.specialoffer.ISpecialOfferViewSlotObject;
   import game.view.popup.reward.RelativeAlignment;
   import idv.cjcat.signals.Signal;
   
   public class ViewSlotEntry
   {
      
      public static const NULL:ViewSlotEntry = new ViewSlotEntry(null);
      
      private static var EMPTY_OBJECT:Object = {};
       
      
      protected var viewDescription:Object;
      
      private var _type:Class;
      
      private var _constructorParams:Array;
      
      public const signal_removed:Signal = new Signal(ViewSlotEntry);
      
      public function ViewSlotEntry(param1:Object)
      {
         super();
         if(param1 != null)
         {
            this.viewDescription = param1;
         }
         else
         {
            this.viewDescription = EMPTY_OBJECT;
         }
      }
      
      public static function sort_byPriority(param1:ViewSlotEntry, param2:ViewSlotEntry) : int
      {
         return param1.priority - param2.priority;
      }
      
      public function dispose() : void
      {
      }
      
      public function get params() : Object
      {
         return viewDescription;
      }
      
      public function get assetClip() : String
      {
         return viewDescription.assetClip;
      }
      
      public function get assetIdent() : String
      {
         return viewDescription.assetIdent;
      }
      
      public function get slot() : String
      {
         return viewDescription.slot;
      }
      
      protected function get priority() : Number
      {
         return viewDescription.priority;
      }
      
      public function setObjectFactory(param1:Class, ... rest) : void
      {
         this._type = param1;
         this._constructorParams = rest;
      }
      
      public function createObject() : ISpecialOfferViewSlotObject
      {
         if(_type)
         {
            return TypeUtil.createInstance(_type,_constructorParams);
         }
         if(viewDescription.type == "ViewSlotOneTimeTextAnimation")
         {
            return new ViewSlotOneTimeTextAnimation(this);
         }
         if(viewDescription.type == "ViewSlotStaticText")
         {
            return new ViewSlotStaticText(this);
         }
         return null;
      }
      
      public function createAlignment() : RelativeAlignment
      {
         var _loc1_:RelativeAlignment = new RelativeAlignment();
         if(viewDescription.alignment)
         {
            _loc1_.alignHorizontal = viewDescription.alignment["horizontal"];
            _loc1_.alignVertical = viewDescription.alignment["vertical"];
            if(viewDescription.alignment["internal"] != undefined)
            {
               _loc1_.internalAlignment = viewDescription.alignment["internal"] == true;
            }
         }
         if(viewDescription.padding)
         {
            if(viewDescription.padding.x)
            {
               _loc1_.paddingLeft = viewDescription.padding.x;
            }
            if(viewDescription.padding.y)
            {
               _loc1_.paddingTop = viewDescription.padding.y;
            }
            if(viewDescription.padding.left)
            {
               _loc1_.paddingLeft = viewDescription.padding.left;
            }
            if(viewDescription.padding.top)
            {
               _loc1_.paddingTop = viewDescription.padding.top;
            }
            if(viewDescription.padding.right)
            {
               _loc1_.paddingRight = viewDescription.padding.right;
            }
            if(viewDescription.padding.bottom)
            {
               _loc1_.paddingBottom = viewDescription.padding.bottom;
            }
            if(viewDescription.padding.horizontal)
            {
               var _loc2_:* = viewDescription.padding.horizontal;
               _loc1_.paddingRight = _loc2_;
               _loc1_.paddingLeft = _loc2_;
            }
            if(viewDescription.padding.vertical)
            {
               _loc2_ = viewDescription.padding.vertical;
               _loc1_.paddingBottom = _loc2_;
               _loc1_.paddingTop = _loc2_;
            }
            if(viewDescription.padding.all)
            {
               _loc2_ = viewDescription.padding.all;
               _loc1_.paddingBottom = _loc2_;
               _loc2_ = _loc2_;
               _loc1_.paddingTop = _loc2_;
               _loc2_ = _loc2_;
               _loc1_.paddingRight = _loc2_;
               _loc1_.paddingLeft = _loc2_;
            }
         }
         return _loc1_;
      }
   }
}
