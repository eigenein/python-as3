package game.data.reward
{
   import game.data.storage.titan.TitanDescription;
   
   public class RewardTitan
   {
       
      
      private var _desc:TitanDescription;
      
      public function RewardTitan(param1:TitanDescription)
      {
         super();
         this._desc = param1;
      }
      
      public function get desc() : TitanDescription
      {
         return _desc;
      }
   }
}
