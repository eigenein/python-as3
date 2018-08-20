package game.mechanics.titan_arena.popup.raid
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class TitanArenaRaidPopupBattleItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public const clan_icon:ClanIconWithFrameClip = new ClanIconWithFrameClip();
      
      public const portrait:PlayerPortraitClip = new PlayerPortraitClip();
      
      public const tf_name:ClipLabel = new ClipLabel();
      
      public const tf_clan:SpecialClipLabel = new SpecialClipLabel();
      
      public const tf_power:ClipLabel = new ClipLabel();
      
      public const tf_label_attack:ClipLabel = new ClipLabel();
      
      public const tf_label_defence:ClipLabel = new ClipLabel();
      
      public const icon_victoryPoint_1:ClipSprite = new ClipSprite();
      
      public const icon_victoryPoint_2:ClipSprite = new ClipSprite();
      
      public const tf_points_attack:SpecialClipLabel = new SpecialClipLabel();
      
      public const tf_points_defence:SpecialClipLabel = new SpecialClipLabel();
      
      public const tf_invalidBattle:ClipLabel = new ClipLabel();
      
      public const button_info:ClipButton = new ClipButton();
      
      public const icon_reward:InventoryItemRenderer = new InventoryItemRenderer();
      
      public const layout_battleResult:ClipLayout = new ClipLayoutNone([tf_label_attack,tf_points_attack,tf_label_defence,tf_points_defence,icon_victoryPoint_1,icon_victoryPoint_2,button_info,icon_reward]);
      
      public const bg:GuiClipScale9Image = new GuiClipScale9Image();
      
      public function TitanArenaRaidPopupBattleItemRendererClip()
      {
         super();
      }
   }
}
