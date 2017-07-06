var Quizes = React.createClass({
  getInitialState() {
    return {
      quizes: this.props.quizes,
      quiz: {
        question: '',
        answer: ''
      },
      errors:{}
    }
  },

  handleSubmitQuiz() {
    var that = this;

    $.ajax({
      method: 'POST',
      data: {
        quiz: that.state.quiz,
      },
      url: '/quizes.json',
      success: function(res){
        var newQuizList = that.state.quizes;
        newQuizList.push(res);
        that.setState({
          quizes: newQuizList,
          quiz: {
            question: '',
            answer: ''
          },
          errors: {}
        });
      },
      error: function(res){
        that.setState({errors: res.responseJSON.errors})
      }
    });
  },

  handleQuestionChange(e){
    var newQuiz = this.state.quiz;
    newQuiz.question = e.target.value;
    this.setState({quiz: newQuiz});
  },

  handleAnswerChange(e){
    var newQuiz = this.state.quiz;
    newQuiz.answer = e.target.value;
    this.setState({quiz: newQuiz});
  },

  updateDeleteQuiz(quiz){
    var quizList = this.state.quizes.filter(function(item){
      return quiz.id !== item.id;
    });
    this.setState({quizes: quizList});
  },

  render: function(){
    var that = this;
    quizes = this.state.quizes.map(function(quiz){
      return (
        <Quiz quiz={quiz} key={quiz.id} onQuizDelete={that.updateDeleteQuiz} />
      );
    });

    return (
      <div>
        <h1>Manage Questions</h1>
        <div id="quizes">
          <table>
            <thead>
              <tr>
                <th>Question</th>
                <th>Answer</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              {quizes}
              <tr>
                <td>
                  <input value={this.state.quiz.question}
                         type="text" onChange={this.handleQuestionChange} /><br />
                  <span style={{color: 'red'}}>{this.state.errors.email}</span> 
                </td>
                <td>
                  <input value={this.state.quiz.answer} 
                         type="text" onChange={this.handleAnswerChange} /><br />
                  <span style={{color: 'red'}}>{this.state.errors.email}</span> 
                </td>
                <td>
                  <button onClick={this.handleSubmitQuiz}>Submit Question</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    );
  }
});
