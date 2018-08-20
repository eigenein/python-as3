package game.view.popup.hero.slot
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.VerticalLayout;
   import game.data.storage.pve.mission.MissionItemDropValueObject;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class ClipDropSourcesBlockList extends GuiClipNestedContainer
   {
       
      
      private var slider:GameScrollBar;
      
      public var drop_sources_item:ClipSprite;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      private var _list:GameScrolledList;
      
      private var _signal_select:Signal;
      
      public function ClipDropSourcesBlockList()
      {
         drop_sources_item = new ClipSprite();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         _signal_select = new Signal(MissionItemDropValueObject);
         super();
      }
      
      public function get list() : GameScrolledList
      {
         return _list;
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         slider = new GameScrollBar();
         slider.height = scroll_slider_container.container.height;
         scroll_slider_container.container.addChild(slider);
         var _loc3_:Boolean = false;
         gradient_top.graphics.touchable = _loc3_;
         gradient_bottom.graphics.touchable = _loc3_;
         _list = new GameScrolledList(slider,gradient_top.graphics,gradient_bottom.graphics);
         _list.width = list_container.graphics.width;
         _list.height = list_container.graphics.height;
         list_container.container.addChild(_list);
         _list.itemRendererType = ClipListItemDropSourceRenderer;
         var _loc2_:VerticalLayout = new VerticalLayout();
         _loc2_.gap = 3;
         _list.layout = _loc2_;
         _list.addEventListener("rendererAdd",onListRendererAdded);
         _list.addEventListener("rendererRemove",onListRendererRemoved);
      }
      
      public function setHeight(param1:int) : void
      {
         _list.height = param1 - 2;
         gradient_bottom.graphics.y = param1 - gradient_bottom.graphics.height;
         slider.height = param1;
      }
      
      protected function onListRendererAdded(param1:Event, param2:ClipListItemDropSourceRenderer) : void
      {
         param2.signal_select.add(handler_select);
      }
      
      protected function onListRendererRemoved(param1:Event, param2:ClipListItemDropSourceRenderer) : void
      {
         param2.signal_select.remove(handler_select);
      }
      
      protected function handler_select(param1:MissionItemDropValueObject) : void
      {
         _signal_select.dispatch(param1);
      }
   }
}
