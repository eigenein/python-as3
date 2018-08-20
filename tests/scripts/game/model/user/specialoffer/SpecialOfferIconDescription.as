package game.model.user.specialoffer
{
   import game.assets.battle.AssetClipLink;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupStashEventParams;
   import idv.cjcat.signals.Signal;
   
   public class SpecialOfferIconDescription
   {
       
      
      private var _specialOffer:PlayerSpecialOfferEntry;
      
      private var priority:int;
      
      private var _methodName:String;
      
      private var _icon:String;
      
      private var _asset:AssetClipLink;
      
      private var _iconLabelLocaleId:String;
      
      private var _methodArguments:Array;
      
      public const signal_click:Signal = new Signal(PopupStashEventParams);
      
      public function SpecialOfferIconDescription(param1:PlayerSpecialOfferEntry, param2:Object)
      {
         super();
         this._specialOffer = param1;
         this.priority = param2.priority;
         if(param2.icon is String)
         {
            _icon = param2.icon;
            _asset = new AssetClipLink(AssetStorage.rsx.bundle_icons,param2.icon);
         }
         else if(param2.icon != null)
         {
            _icon = param2.icon.clip;
            _asset = new AssetClipLink(AssetStorage.rsx.getByName(param2.icon.asset),param2.icon.clip);
         }
         _iconLabelLocaleId = param2.iconLabelLocaleId;
         _methodName = param2.methodName;
         _methodArguments = param2.methodArguments;
      }
      
      public static function sort_byPriority(param1:SpecialOfferIconDescription, param2:SpecialOfferIconDescription) : int
      {
         return param1.priority - param2.priority;
      }
      
      public function get methodName() : String
      {
         return _methodName;
      }
      
      public function get icon() : String
      {
         return _icon;
      }
      
      public function get asset() : AssetClipLink
      {
         return _asset;
      }
      
      public function get iconLabelLocaleId() : String
      {
         return _iconLabelLocaleId;
      }
      
      public function get methodArguments() : Array
      {
         return _methodArguments;
      }
      
      public function get specialOffer() : PlayerSpecialOfferEntry
      {
         return _specialOffer;
      }
      
      public function action_click(param1:PopupStashEventParams) : void
      {
         signal_click.dispatch(param1);
      }
   }
}
