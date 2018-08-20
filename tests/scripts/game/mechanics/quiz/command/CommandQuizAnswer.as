package game.mechanics.quiz.command
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.enum.RpcCommandName;
   import game.data.reward.RewardData;
   
   public class CommandQuizAnswer extends CostCommand
   {
       
      
      private var _correctAnswer:int;
      
      private var _isCorrect:Boolean;
      
      public function CommandQuizAnswer(param1:int, param2:int)
      {
         super();
         rpcRequest = new RpcRequest(RpcCommandName.QUIZ_ANSWER);
         rpcRequest.writeParam("answerId",param2);
         rpcRequest.writeParam("time",param1);
      }
      
      public function get correctAnswer() : int
      {
         return _correctAnswer;
      }
      
      public function get isCorrect() : Boolean
      {
         return _isCorrect;
      }
      
      override protected function successHandler() : void
      {
         _reward = new RewardData(result.body.reward);
         _correctAnswer = result.body.rightAnswer;
         _isCorrect = result.body.isAnswerRight;
         super.successHandler();
      }
   }
}
