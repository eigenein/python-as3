package game.assets.storage.rsx
{
   import engine.core.assets.AssetProvider;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.battle.gui.BattleGUIProgressbarBlock;
   import game.battle.gui.BattleGUIWaveCounter;
   import game.battle.gui.BattleGuiReplayControlsClip;
   import game.battle.gui.BattleGuiReplayTeamsClip;
   import game.battle.gui.BattleGuiReplayUsersClip;
   import game.battle.gui.BattleGuiSpeedUpButton;
   import game.battle.gui.BattleGuiToggleButton;
   import game.battle.gui.BattleHpBarClip;
   import game.battle.gui.BattleSpeechBubble;
   import game.battle.gui.UltTitleView;
   import game.battle.gui.block.BattleGuiYourTeamTextBlockClip;
   import game.battle.gui.hero.BattleGUIHeroPortrait;
   import game.battle.gui.teambuffs.BattleTeamEffectIconClip;
   import game.view.popup.battle.BattlePausePopupClip;
   import game.view.popup.battle.BattlePreloaderPopupClip;
   
   public class BattleGUIAsset extends RsxGuiAsset
   {
      
      public static const IDENT:String = "battle_interface";
       
      
      public const fonts:BattleFonts = new BattleFonts();
      
      public function BattleGUIAsset(param1:*)
      {
         super(param1);
      }
      
      override public function complete() : void
      {
         super.complete();
         fonts.completeRsx(data);
      }
      
      override public function prepare(param1:AssetProvider) : void
      {
         super.prepare(param1);
         param1.request(fonts);
      }
      
      public function create_waveCounter() : BattleGUIWaveCounter
      {
         return create(BattleGUIWaveCounter,"mission_wave_counter");
      }
      
      public function create_progressbarBlock() : BattleGUIProgressbarBlock
      {
         return create(BattleGUIProgressbarBlock,"progressbar_block");
      }
      
      public function create_portrait_hero() : BattleGUIHeroPortrait
      {
         return create(BattleGUIHeroPortrait,"hero_portrait");
      }
      
      public function create_portrait_titan() : BattleGUIHeroPortrait
      {
         return create(BattleGUIHeroPortrait,"titan_portrait");
      }
      
      public function create_portrait_back_glow() : GuiAnimation
      {
         return create(GuiAnimation,"animation_SuperRays");
      }
      
      public function create_toggleLabeledButton() : BattleGuiToggleButton
      {
         return create(BattleGuiToggleButton,"toggleLabeledButton");
      }
      
      public function create_toggleSpeedUpButton() : BattleGuiSpeedUpButton
      {
         return create(BattleGuiSpeedUpButton,"ButtonToggleSpeedBase");
      }
      
      public function create_toggleSoundButton() : BattleGuiToggleButton
      {
         return create(BattleGuiToggleButton,"toggleSoundButton");
      }
      
      public function create_togglePlayPauseButton() : BattleGuiToggleButton
      {
         return create(BattleGuiToggleButton,"togglePlayPauseButton");
      }
      
      public function create_pausePopup() : BattlePausePopupClip
      {
         return create(BattlePausePopupClip,"popup_battle_pause");
      }
      
      public function create_clanWarPausePopup() : BattlePausePopupClip
      {
         return create(BattlePausePopupClip,"popup_battle_pause_clanwar");
      }
      
      public function create_preloaderPopup() : BattlePreloaderPopupClip
      {
         return create(BattlePreloaderPopupClip,"popup_preloader");
      }
      
      public function create_battleBarRed() : BattleHpBarClip
      {
         return create(BattleHpBarClip,"battle_bar_red");
      }
      
      public function create_battleBarGreen() : BattleHpBarClip
      {
         return create(BattleHpBarClip,"battle_bar_green");
      }
      
      public function create_battleBarYellow() : BattleHpBarClip
      {
         return create(BattleHpBarClip,"battle_bar_yellow");
      }
      
      public function create_ultTitle() : UltTitleView
      {
         return create(UltTitleView,"ult_decor");
      }
      
      public function create_speechBubbleGreen() : BattleSpeechBubble
      {
         return create(BattleSpeechBubble,"speechBubbleGreen");
      }
      
      public function create_speechBubbleRed() : BattleSpeechBubble
      {
         return create(BattleSpeechBubble,"speechBubbleRed");
      }
      
      public function create_heroBrownBG() : GuiClipNestedContainer
      {
         return create(GuiClipNestedContainer,"heroBrownBG");
      }
      
      public function init_block_replay_teams(param1:BattleGuiReplayTeamsClip) : void
      {
         initGuiClip(param1,"block_replay_teams");
      }
      
      public function init_block_replay_users(param1:BattleGuiReplayUsersClip) : void
      {
         initGuiClip(param1,"block_replay_users");
      }
      
      public function init_block_replay_controls(param1:BattleGuiReplayControlsClip) : void
      {
         initGuiClip(param1,"block_replay_controls");
      }
      
      public function createTeamEffectIcon() : BattleTeamEffectIconClip
      {
         return create(BattleTeamEffectIconClip,"team_effect_icon");
      }
      
      public function create_your_team_text_block() : BattleGuiYourTeamTextBlockClip
      {
         return create(BattleGuiYourTeamTextBlockClip,"your_team_text_block");
      }
   }
}
