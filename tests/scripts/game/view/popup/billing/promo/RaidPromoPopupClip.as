package game.view.popup.billing.promo
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.FramedImageClip;
   import game.view.gui.components.SpecialClipLabel;
   
   public class RaidPromoPopupClip extends PopupClipBase
   {
       
      
      public var tf_0:SpecialClipLabel;
      
      public var tf_1:SpecialClipLabel;
      
      public var tf_2:SpecialClipLabel;
      
      public var tf_reward_0:SpecialClipLabel;
      
      public var tf_reward_1:SpecialClipLabel;
      
      public var tf_reward_2:SpecialClipLabel;
      
      public var tf_reward_3:SpecialClipLabel;
      
      public var image:FramedImageClip;
      
      public var button_go:ClipButtonLabeled;
      
      public function RaidPromoPopupClip()
      {
         tf_0 = new SpecialClipLabel();
         tf_1 = new SpecialClipLabel();
         tf_2 = new SpecialClipLabel();
         tf_reward_0 = new SpecialClipLabel();
         tf_reward_1 = new SpecialClipLabel();
         tf_reward_2 = new SpecialClipLabel();
         tf_reward_3 = new SpecialClipLabel();
         image = new FramedImageClip();
         button_go = new ClipButtonLabeled();
         super();
      }
   }
}
