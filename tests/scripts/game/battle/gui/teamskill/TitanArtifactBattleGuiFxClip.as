package game.battle.gui.teamskill
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipContainer;
   import game.view.specialoffer.welcomeback.ClipLabelInContainer;
   
   public class TitanArtifactBattleGuiFxClip extends ClipAnimatedContainer
   {
       
      
      public const bg:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const container_icon:GuiClipContainer = new GuiClipContainer();
      
      public const tf_title:ClipLabelInContainer = new ClipLabelInContainer();
      
      public const tf_name:ClipLabelInContainer = new ClipLabelInContainer();
      
      public const tf_percent:ClipLabelInContainer = new ClipLabelInContainer();
      
      public function TitanArtifactBattleGuiFxClip()
      {
         super();
      }
   }
}
