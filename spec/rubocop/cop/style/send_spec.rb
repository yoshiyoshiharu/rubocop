# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Style::Send, :config do
  context 'with send' do
    context 'and with a receiver' do
      it 'registers an offense for an invocation with args' do
        expect_offense(<<~RUBY)
          Object.send(foo)
                 ^^^^ Prefer `Object#__send__` or `Object#public_send` to `send`.
        RUBY
      end

      context 'when using safe navigation operator' do
        it 'registers an offense for an invocation with args' do
          expect_offense(<<~RUBY)
            Object&.send(foo)
                    ^^^^ Prefer `Object#__send__` or `Object#public_send` to `send`.
          RUBY
        end
      end

      it 'does not register an offense for an invocation without args' do
        expect_no_offenses('Object.send')
      end
    end

    context 'and without a receiver' do
      it 'registers an offense for an invocation with args' do
        expect_offense(<<~RUBY)
          send(foo)
          ^^^^ Prefer `Object#__send__` or `Object#public_send` to `send`.
        RUBY
      end

      it 'does not register an offense for an invocation without args' do
        expect_no_offenses('send')
      end
    end
  end

  context 'with __send__' do
    context 'and with a receiver' do
      it 'does not register an offense for an invocation with args' do
        expect_no_offenses('Object.__send__(foo)')
      end

      it 'does not register an offense for an invocation without args' do
        expect_no_offenses('Object.__send__')
      end
    end

    context 'and without a receiver' do
      it 'does not register an offense for an invocation with args' do
        expect_no_offenses('__send__(foo)')
      end

      it 'does not register an offense for an invocation without args' do
        expect_no_offenses('__send__')
      end
    end
  end

  context 'with public_send' do
    context 'and with a receiver' do
      it 'does not register an offense for an invocation with args' do
        expect_no_offenses('Object.public_send(foo)')
      end

      it 'does not register an offense for an invocation without args' do
        expect_no_offenses('Object.public_send')
      end
    end

    context 'and without a receiver' do
      it 'does not register an offense for an invocation with args' do
        expect_no_offenses('public_send(foo)')
      end

      it 'does not register an offense for an invocation without args' do
        expect_no_offenses('public_send')
      end
    end
  end
end
