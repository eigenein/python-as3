package game.view.popup.resource
{
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ClipBasedPopup;
   import idv.cjcat.signals.Signal;
   
   public class NotEnoughResourcePopup extends ClipBasedPopup
   {
       
      
      private var mediator:NotEnoughResourcePopupMediator;
      
      protected var clip:NotEnoughResourcePopupClip;
      
      private var _signal_okClose:Signal;
      
      public function NotEnoughResourcePopup(param1:NotEnoughResourcePopupMediator)
      {
         _signal_okClose = new Signal(NotEnoughResourcePopup);
         super(null);
         this.mediator = param1;
         stashParams.windowName = "notEnoughResource";
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:int = width;
         var _loc2_:int = height;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(NotEnoughResourcePopupClip,"popup_not_enough_resource");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.button_ok.signal_click.add(mediator.navigate);
         clip.button_ok.label = mediator.actionLabel;
         var _loc1_:VerticalLayout = clip.layout_text.layout as VerticalLayout;
         _loc1_.gap = 7;
         _loc1_.paddingTop = 10;
         _loc1_.paddingBottom = 20;
         clip.tf_header.text = mediator.windowTitle;
         clip.tf_message.height = NaN;
         clip.tf_message.maxHeight = 500;
         clip.tf_message.text = mediator.contentText;
         clip.layout_text.height = NaN;
         clip.layout_text.validate();
         clip.bg.graphics.height = clip.layout_text.graphics.height;
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
      }
      
      override public function dispose() : void
      {
         _signal_okClose.dispatch(this);
         _signal_okClose.clear();
         super.dispose();
      }
   }
}
