package game.view.popup.clan
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.mediator.gui.popup.clan.ClanValueObject;
   import game.mediator.gui.popup.clan.FriendClanValueObject;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class ClanSearchListClip extends GuiClipNestedContainer
   {
       
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var empty:Vector.<GuiClipScale9Image>;
      
      private var _list:GameScrolledList;
      
      private var _signal_select:Signal;
      
      private var _signal_showFriends:Signal;
      
      private var _signal_clanProfile:Signal;
      
      public function ClanSearchListClip()
      {
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         empty = new Vector.<GuiClipScale9Image>();
         _signal_select = new Signal(ClanValueObject);
         _signal_showFriends = new Signal(FriendClanValueObject);
         _signal_clanProfile = new Signal(ClanValueObject);
         super();
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get signal_showFriends() : Signal
      {
         return _signal_showFriends;
      }
      
      public function get signal_clanProfile() : Signal
      {
         return _signal_clanProfile;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc4_:Boolean = false;
         gradient_top.graphics.touchable = _loc4_;
         gradient_bottom.graphics.touchable = _loc4_;
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = scroll_slider_container.graphics.height;
         scroll_slider_container.container.addChild(_loc2_);
         _list = new GameScrolledList(_loc2_,gradient_top.graphics,gradient_bottom.graphics);
         var _loc3_:VerticalLayout = new VerticalLayout();
         _list.layout = _loc3_;
         _loc3_.gap = 5;
         _list.width = list_container.graphics.width;
         _list.height = list_container.graphics.height;
         list_container.container.addChild(_list);
         _list.itemRendererType = ClanSearchListItemRenderer;
         _list.addEventListener("rendererAdd",onListRendererAdded);
         _list.addEventListener("rendererRemove",onListRendererRemoved);
      }
      
      public function updateListData(param1:ListCollection) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _list.dataProvider = param1;
            _loc2_ = empty.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               empty[_loc3_].graphics.visible = param1.length <= _loc3_;
               _loc3_++;
            }
         }
      }
      
      private function onListRendererAdded(param1:Event, param2:ClanSearchListItemRenderer) : void
      {
         param2.signal_select.add(handler_select);
         param2.signal_clanProfile.add(handler_clanProfile);
         param2.signal_friendList.add(handler_friendList);
      }
      
      private function onListRendererRemoved(param1:Event, param2:ClanSearchListItemRenderer) : void
      {
         param2.signal_select.remove(handler_select);
         param2.signal_clanProfile.remove(handler_clanProfile);
         param2.signal_friendList.remove(handler_friendList);
      }
      
      private function handler_select(param1:ClanValueObject) : void
      {
         _signal_select.dispatch(param1);
      }
      
      private function handler_clanProfile(param1:ClanValueObject) : void
      {
         _signal_clanProfile.dispatch(param1);
      }
      
      private function handler_friendList(param1:FriendClanValueObject) : void
      {
         _signal_showFriends.dispatch(param1);
      }
   }
}
