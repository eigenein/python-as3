package game.view.popup.friends.referrer
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   
   public class ReferrerPopupListItemRenderer extends ListItemRenderer
   {
       
      
      protected var clip:ReferrerPopupListItemRendererClip;
      
      private var _signal_select:Signal;
      
      public function ReferrerPopupListItemRenderer()
      {
         _signal_select = new Signal(FriendDataProvider);
         super();
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = createClip();
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
         clip.signal_click.add(handler_click);
      }
      
      protected function createClip() : ReferrerPopupListItemRendererClip
      {
         return AssetStorage.rsx.popup_theme.create(ReferrerPopupListItemRendererClip,"friend_select_list_item_renderer");
      }
      
      override public function set data(param1:Object) : void
      {
         .super.data = param1;
         if(param1)
         {
            clip.data = param1 as FriendDataProvider;
         }
      }
      
      protected function handler_click() : void
      {
         _signal_select.dispatch(data as FriendDataProvider);
      }
   }
}
