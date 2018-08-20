package game.view.gui.components
{
   import feathers.controls.LayoutGroup;
   import feathers.layout.AnchorLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import starling.display.Image;
   
   public class HeroPortraitBase extends LayoutGroup
   {
       
      
      protected var _data:UnitEntryValueObject;
      
      protected var frame:Image;
      
      protected var _icon:Image;
      
      protected var background:Image;
      
      public function HeroPortraitBase()
      {
         super();
      }
      
      public function get icon() : Image
      {
         return _icon;
      }
      
      public function get data() : UnitEntryValueObject
      {
         return _data;
      }
      
      public function set data(param1:UnitEntryValueObject) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         invalidate("data");
      }
      
      public function set dataDesc(param1:UnitDescription) : void
      {
         if(param1 is TitanDescription)
         {
            data = new TitanEntryValueObject(param1 as TitanDescription,null);
         }
         else if(param1 is HeroDescription)
         {
            data = new HeroEntryValueObject(param1 as HeroDescription,null);
         }
      }
      
      public function set disabled(param1:Boolean) : void
      {
         if(frame)
         {
            var _loc2_:* = !!param1?7829367:16777215;
            _icon.color = _loc2_;
            _loc2_ = _loc2_;
            frame.color = _loc2_;
            background.color = _loc2_;
         }
      }
      
      public function set weakDisabled(param1:Boolean) : void
      {
         if(frame)
         {
            var _loc2_:* = !!param1?12303291:16777215;
            _icon.color = _loc2_;
            _loc2_ = _loc2_;
            frame.color = _loc2_;
            background.color = _loc2_;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid("data"))
         {
            commitData();
         }
      }
      
      protected function commitData() : void
      {
         if(data)
         {
            icon.texture = data.icon;
            frame.texture = data.qualityFrame;
            background.texture = data.qualityBackground;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         layout = new AnchorLayout();
         background = new Image(AssetStorage.rsx.popup_theme.missing_texture);
         background.touchable = false;
         background.width = 80;
         background.height = 80;
         addChild(background);
         _icon = new Image(AssetStorage.rsx.popup_theme.missing_texture);
         icon.width = 80;
         icon.height = 80;
         addChild(icon);
         var _loc1_:int = 8;
         icon.x = _loc1_;
         background.x = _loc1_;
         _loc1_ = 8;
         icon.y = _loc1_;
         background.y = _loc1_;
         frame = new Image(AssetStorage.rsx.popup_theme.missing_texture);
         frame.touchable = false;
         _loc1_ = 96;
         frame.height = _loc1_;
         frame.width = _loc1_;
         addChild(frame);
      }
   }
}
