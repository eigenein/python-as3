package game.view.popup.friends
{
   import feathers.controls.Label;
   import feathers.layout.HorizontalLayout;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.view.gui.components.GameButton;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   
   public class FriendListItemRenderer extends ListItemRenderer
   {
       
      
      protected var nameLabel:Label;
      
      private var _signal_select:Signal;
      
      public function FriendListItemRenderer()
      {
         super();
         _signal_select = new Signal(FriendDataProvider);
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:FriendDataProvider = data as FriendDataProvider;
         if(_loc1_)
         {
            nameLabel.text = _loc1_.name;
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:FriendDataProvider = data as FriendDataProvider;
         if(!_loc2_)
         {
         }
         .super.data = param1;
         _loc2_ = data as FriendDataProvider;
         if(!_loc2_)
         {
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         layout = new HorizontalLayout();
         nameLabel = GameLabel.label();
         addChild(nameLabel);
         var _loc1_:GameButton = GameButton.staticButton(">",buttonClick);
         addChild(_loc1_);
      }
      
      private function buttonClick() : void
      {
         _signal_select.dispatch(data as FriendDataProvider);
      }
   }
}
