package game.mediator.gui.popup.clan.editicon
{
   import game.mediator.gui.popup.clan.ClanEditIconPopupMediator;
   import org.osflash.signals.Signal;
   import starling.textures.Texture;
   
   public class ClanEditIconEmblemValueObject extends ClanEditIconValueObject
   {
       
      
      private var mediator:ClanEditIconPopupMediator;
      
      private var _emblemTexture:Texture;
      
      public function ClanEditIconEmblemValueObject(param1:int, param2:ClanEditIconPopupMediator, param3:Texture)
      {
         super(param1);
         this.mediator = param2;
         this._emblemTexture = param3;
      }
      
      public function get signal_graphicsUpdated() : Signal
      {
         return mediator.signal_emblemUpdated;
      }
      
      public function get emblemTexture() : Texture
      {
         return _emblemTexture;
      }
      
      public function get color() : uint
      {
         return mediator.color3.color;
      }
   }
}
