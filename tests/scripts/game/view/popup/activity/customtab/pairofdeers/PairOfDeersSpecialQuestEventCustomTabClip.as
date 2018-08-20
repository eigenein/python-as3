package game.view.popup.activity.customtab.pairofdeers
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.hero.ClipHeroPreview;
   
   public class PairOfDeersSpecialQuestEventCustomTabClip extends GuiClipNestedContainer
   {
       
      
      public const button_replay:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const tf_text_1:ClipLabel = new ClipLabel();
      
      public const tf_text_2:ClipLabel = new ClipLabel();
      
      public const tf_text_3:ClipLabel = new ClipLabel();
      
      public const layout_text_1:ClipLayout = ClipLayout.verticalMiddleCenter(0,tf_text_1);
      
      public const layout_text_2:ClipLayout = ClipLayout.verticalMiddleCenter(0,tf_text_2);
      
      public const layout_text_3:ClipLayout = ClipLayout.verticalMiddleCenter(0,tf_text_3);
      
      public const skill_1:SkillIconWithHeroLabelClip = new SkillIconWithHeroLabelClip();
      
      public const skill_2:SkillIconWithHeroLabelClip = new SkillIconWithHeroLabelClip();
      
      public const skill_3:SkillIconWithHeroLabelClip = new SkillIconWithHeroLabelClip();
      
      public const skill_4:SkillIconWithHeroLabelClip = new SkillIconWithHeroLabelClip();
      
      public const skill_5:SkillIconWithHeroLabelClip = new SkillIconWithHeroLabelClip();
      
      public const skill_6:SkillIconWithHeroLabelClip = new SkillIconWithHeroLabelClip();
      
      public const tf_skills_1:ClipLabel = new ClipLabel();
      
      public const tf_skills_2:ClipLabel = new ClipLabel();
      
      public const container_hero_1:ClipHeroPreview = new ClipHeroPreview();
      
      public const container_hero_2:ClipHeroPreview = new ClipHeroPreview();
      
      public function PairOfDeersSpecialQuestEventCustomTabClip()
      {
         super();
      }
   }
}
