package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.gear.GearItemDescription;
   import game.mediator.gui.popup.hero.HeroGearListValueObject;
   import game.model.user.hero.HeroEntry;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.gui.components.GuiClipLayoutContainer;
   import idv.cjcat.signals.Signal;
   
   public class HeroPopupGearList extends GuiClipNestedContainer
   {
       
      
      private const verticalLayoutGap:Number = 10;
      
      private var scrollContainer:GameScrollContainer;
      
      private var rendererList:Vector.<HeroPopupGearSetClip>;
      
      private var _signal_itemSelect:Signal;
      
      public var tf_header:ClipLabel;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var image_item:ClipSprite;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function HeroPopupGearList()
      {
         _signal_itemSelect = new Signal(GearItemDescription);
         tf_header = new ClipLabel();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         image_item = new ClipSprite();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
      
      public function dispose() : void
      {
         updateGear(null);
      }
      
      public function get signal_itemSelect() : Signal
      {
         return _signal_itemSelect;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc4_:Boolean = false;
         gradient_top.graphics.touchable = _loc4_;
         gradient_bottom.graphics.touchable = _loc4_;
         var _loc3_:GameScrollBar = new GameScrollBar();
         _loc3_.height = scroll_slider_container.container.height;
         scroll_slider_container.container.addChild(_loc3_);
         scrollContainer = new GameScrollContainer(_loc3_,gradient_top.graphics,gradient_bottom.graphics);
         scrollContainer.width = list_container.container.width;
         scrollContainer.height = list_container.container.height;
         list_container.container.addChild(scrollContainer);
         var _loc2_:VerticalLayout = new VerticalLayout();
         scrollContainer.layout = _loc2_;
         _loc2_.gap = 10;
         _loc2_.paddingTop = 10;
         _loc2_.paddingBottom = 20;
         tf_header.maxHeight = Infinity;
         tf_header.text = Translate.translate("UI_HERO_DIALOG_GEAR_LIST_HEADER");
         scrollContainer.addChild(tf_header);
         rendererList = new Vector.<HeroPopupGearSetClip>();
      }
      
      public function updateGear(param1:ListCollection, param2:HeroEntry = null) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = rendererList.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            scrollContainer.removeChild(rendererList[_loc6_].graphics,true);
            rendererList[_loc6_].dispose();
            _loc6_++;
         }
         rendererList = new Vector.<HeroPopupGearSetClip>();
         var _loc7_:uint = 0;
         if(param1)
         {
            _loc5_ = param1.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc3_ = param1.getItemAt(_loc6_) as HeroGearListValueObject;
               if(param2.color.color.id > _loc3_.color.id)
               {
                  _loc7_++;
               }
               _loc4_ = AssetStorage.rsx.popup_theme.create(HeroPopupGearSetClip,"hero_popup_gear_list_set") as HeroPopupGearSetClip;
               _loc4_.signal_itemSelect.add(handler_itemSelect);
               scrollContainer.addChild(_loc4_.graphics);
               rendererList.push(_loc4_);
               _loc4_.data = _loc3_;
               _loc6_++;
            }
         }
         scrollContainer.invalidate();
         scrollContainer.validate();
         var _loc8_:* = 0;
         if(_loc7_ > 0)
         {
            _loc8_ = Number(Math.min(tf_header.height + 10 + _loc7_ * _loc4_.graphics.height + 10 * (_loc7_ - 1),scrollContainer.maxVerticalScrollPosition));
         }
         scrollContainer.scrollToPosition(NaN,_loc8_,0);
      }
      
      private function handler_itemSelect(param1:GearItemDescription) : void
      {
         _signal_itemSelect.dispatch(param1);
      }
   }
}
