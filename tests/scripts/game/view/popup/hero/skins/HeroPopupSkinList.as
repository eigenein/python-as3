package game.view.popup.hero.skins
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.VerticalLayout;
   import game.mediator.gui.popup.hero.HeroPopupMediator;
   import game.mediator.gui.popup.hero.skin.HeroPopupSkinValueObject;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.SpecialClipLabel;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class HeroPopupSkinList extends GuiClipNestedContainer
   {
       
      
      public var result_tf:SpecialClipLabel;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var skin_list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      private var list:GameScrolledList;
      
      private var _mediator:HeroPopupMediator;
      
      public function HeroPopupSkinList()
      {
         result_tf = new SpecialClipLabel();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         skin_list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
      
      public function set mediator(param1:HeroPopupMediator) : void
      {
         _mediator = param1;
      }
      
      public function get mediator() : HeroPopupMediator
      {
         return _mediator;
      }
      
      public function update() : void
      {
         list.dataProvider = mediator.skinItems;
         result_tf.text = Translate.translate("UI_DIALOG_HERO_GUISE_TOTAL_BONUS");
         skin_list_container.container.addChild(list);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = scroll_slider_container.graphics.height;
         scroll_slider_container.container.addChild(_loc2_);
         list = new GameScrolledList(_loc2_,gradient_top.graphics,gradient_bottom.graphics);
         list.isSelectable = true;
         list.width = skin_list_container.graphics.width;
         list.height = skin_list_container.graphics.height;
         list.addEventListener("change",onListChange);
         list.itemRendererType = SkinListItemRenderer;
         var _loc3_:VerticalLayout = new VerticalLayout();
         _loc3_.paddingTop = 0;
         _loc3_.paddingBottom = 5;
         _loc3_.gap = 5;
         list.layout = _loc3_;
      }
      
      private function onListChange(param1:Event) : void
      {
         if(list.selectedItem)
         {
            mediator.signal_skinBrowse.dispatch((list.selectedItem as HeroPopupSkinValueObject).skin);
         }
      }
      
      public function getSkinRendererBySkinID(param1:uint) : SkinListItemRenderer
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:DisplayObjectContainer = list.viewPort as DisplayObjectContainer;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.numChildren)
         {
            _loc2_ = _loc3_.getChildAt(_loc4_) as SkinListItemRenderer;
            if(_loc2_ && _loc2_.data)
            {
               if((_loc2_.data as HeroPopupSkinValueObject).skin.id == param1)
               {
                  return _loc2_;
               }
            }
            _loc4_++;
         }
         return null;
      }
   }
}
