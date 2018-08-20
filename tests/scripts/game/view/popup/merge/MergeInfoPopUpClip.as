package game.view.popup.merge
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   
   public class MergeInfoPopUpClip extends GuiClipNestedContainer
   {
       
      
      public var tf_title:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var tf_x2:ClipLabel;
      
      public var tf_cooldown:SpecialClipLabel;
      
      public var bonus_renderer_1:MergeInfoBonusRendererClip;
      
      public var bonus_renderer_2:MergeInfoBonusRendererClip;
      
      public var bonus_renderer_3:MergeInfoBonusRendererClip;
      
      public var bonus_renderer_4:MergeInfoBonusRendererClip;
      
      public var bonus_renderer_5:MergeInfoBonusRendererClip;
      
      public var bonus_renderer_6:MergeInfoBonusRendererClip;
      
      public var action_btn:ClipButtonLabeled;
      
      public function MergeInfoPopUpClip()
      {
         tf_title = new ClipLabel();
         tf_desc = new ClipLabel();
         tf_x2 = new ClipLabel();
         tf_cooldown = new SpecialClipLabel();
         bonus_renderer_1 = new MergeInfoBonusRendererClip();
         bonus_renderer_2 = new MergeInfoBonusRendererClip();
         bonus_renderer_3 = new MergeInfoBonusRendererClip();
         bonus_renderer_4 = new MergeInfoBonusRendererClip();
         bonus_renderer_5 = new MergeInfoBonusRendererClip();
         bonus_renderer_6 = new MergeInfoBonusRendererClip();
         action_btn = new ClipButtonLabeled();
         super();
      }
   }
}
