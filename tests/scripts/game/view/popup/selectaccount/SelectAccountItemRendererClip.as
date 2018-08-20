package game.view.popup.selectaccount
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class SelectAccountItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var server_tf:ClipLabel;
      
      public var title_tf:ClipLabel;
      
      public var id_tf:ClipLabel;
      
      public var heroes_tf:ClipLabel;
      
      public var power_tf:ClipLabel;
      
      public var vip_tf:ClipLabel;
      
      public var recommended_tf:ClipLabel;
      
      public var action_btn_1:ClipButtonLabeled;
      
      public var action_btn_2:ClipButtonLabeled;
      
      public var portrait:PlayerPortraitClip;
      
      public var layout_content:ClipLayout;
      
      public function SelectAccountItemRendererClip()
      {
         server_tf = new ClipLabel();
         title_tf = new ClipLabel();
         id_tf = new ClipLabel();
         heroes_tf = new ClipLabel();
         power_tf = new ClipLabel();
         vip_tf = new ClipLabel();
         recommended_tf = new ClipLabel();
         action_btn_1 = new ClipButtonLabeled();
         action_btn_2 = new ClipButtonLabeled();
         portrait = new PlayerPortraitClip();
         layout_content = ClipLayout.horizontalMiddleCentered(5,portrait);
         super();
      }
   }
}
